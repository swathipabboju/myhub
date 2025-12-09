import 'package:flutter/material.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'package:flutter/services.dart';

/// AnimatedLoader — plays an image sequence using `image_sequence_animator`.
///
/// - `frameDuration` controls frame timing (converted to fps).
/// - `fullScreen: true` will expand the animator to fill its parent.
class AnimatedLoader extends StatelessWidget {
  final double size;
  final Duration frameDuration;
  final bool fullScreen;
  final bool isLooping;
  // background options
  final bool bgEnabled;
  final Duration bgFrameDuration;
  final BoxFit bgFit;

  const AnimatedLoader({Key? key,
    this.size = 64,
    this.frameDuration = const Duration(milliseconds: 300),
    this.fullScreen = false,
    this.isLooping = true,
    this.bgEnabled = true,
    this.bgFrameDuration = const Duration(milliseconds: 300),
    this.bgFit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // use the existing subfolder structure
    final frames = List<String>.generate(5, (i) => 'assets/loader/loader${i + 1}.png');

    final ms = frameDuration.inMilliseconds > 0 ? frameDuration.inMilliseconds : 400;
    final fps = 400.0 / ms;

    final loaderAnimator = ImageSequenceAnimator(
      '',
      '',
      1,
      5,
      'png',
      5,
      fullPaths: frames,
      fps: fps,
      isLooping: isLooping,
      isAutoPlay: true,
    );

    // background animator (optional)
    Widget? bgWidget;
    if (bgEnabled) {
      final bgFrames = List<String>.generate(4, (i) => 'assets/background/bg${i + 1}.png');
      final bgMs = bgFrameDuration.inMilliseconds > 0 ? bgFrameDuration.inMilliseconds : 400;
      final bgFps = 400.0 / bgMs;

      final bgAnimator = ImageSequenceAnimator(
        '',
        '',
        1,
        4,
        'png',
        4,
        fullPaths: bgFrames,
        fps: bgFps,
        isLooping: true,
        isAutoPlay: true,
      );

      // Make background expand and fit according to bgFit
      bgWidget = SizedBox.expand(
        child: FittedBox(
          fit: bgFit,
          alignment: Alignment.center,
          child: SizedBox(width: size, height: size, child: bgAnimator),
        ),
      );
    }

    final loaderWidget = SizedBox(width: size, height: size, child: loaderAnimator);

    // helper to check asset availability
    Future<List<String>> _checkAssets(List<String> paths) async {
      final missing = <String>[];
      for (final p in paths) {
        try {
          await rootBundle.load(p);
        } catch (_) {
          missing.add(p);
        }
      }
      return missing;
    }

    final allPaths = <String>[];
    allPaths.addAll(frames);
    if (bgEnabled) {
      allPaths.addAll(List<String>.generate(4, (i) => 'assets/background/bg${i + 1}.png'));
    }

    return FutureBuilder<List<String>>(
      future: _checkAssets(allPaths),
      builder: (context, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final missing = snap.data ?? <String>[];
        if (missing.isNotEmpty) {
          for (final p in missing) {
            // ignore: avoid_print
            print('Missing asset: $p');
          }
          return Container(
            color: Colors.black,
            child: const Center(
              child: Text('Missing assets — check console for paths', style: TextStyle(color: Colors.white)),
            ),
          );
        }

        if (fullScreen) {
          // Expand the loader to cover the whole screen as well.
          final loaderExpanded = SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              alignment: Alignment.center,
              child: SizedBox(width: size, height: size, child: loaderAnimator),
            ),
          );

          return Stack(children: [
            if (bgWidget != null) bgWidget,
            loaderExpanded,
          ]);
        }

        if (bgWidget != null) {
          return Stack(alignment: Alignment.center, children: [bgWidget, loaderWidget]);
        }

        return loaderWidget;
      },
    );
  }
}
