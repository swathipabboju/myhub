import 'package:flutter/material.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';
import 'package:flutter/services.dart';

class AnimatedLoader extends StatelessWidget {
  final double size;
  final Duration frameDuration;
  final bool fullScreen;
  final bool isLooping;
  final bool bgEnabled;
  final Duration bgFrameDuration;
  final BoxFit bgFit;

  const AnimatedLoader({
    Key? key,
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
    final loaderFrames =
        List<String>.generate(5, (i) => 'assets/loader/loader${i + 1}.png');
    final ms = frameDuration.inMilliseconds > 0 ? frameDuration.inMilliseconds : 400;
    final fps = 1000.0 / ms;

    final loaderAnimator = ImageSequenceAnimator(
      '',
      '',
      1,
      5,
      'png',
      5,
      fullPaths: loaderFrames,
      fps: fps,
      isLooping: isLooping,
      isAutoPlay: true,
    );

    Widget loaderWidget;

    if (fullScreen) {
      loaderWidget = SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: loaderAnimator,
          ),
        ),
      );
    } else {
      loaderWidget = SizedBox(width: size, height: size, child: loaderAnimator);
    }

    // Background
    Widget? bgWidget;
    if (bgEnabled) {
      final bgFrames =
          List<String>.generate(4, (i) => 'assets/background/bg${i + 1}.png');
      final bgMs = bgFrameDuration.inMilliseconds > 0 ? bgFrameDuration.inMilliseconds : 400;
      final bgFps = 1000.0 / bgMs;

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

      bgWidget = SizedBox.expand(
        child: FittedBox(
          fit: bgFit,
          alignment: Alignment.center,
          child: SizedBox(
            width: fullScreen
                ? MediaQuery.of(context).size.width
                : size,
            height: fullScreen
                ? MediaQuery.of(context).size.height
                : size,
            child: bgAnimator,
          ),
        ),
      );
    }

    return Stack(
      children: [
        if (bgWidget != null) bgWidget,
        loaderWidget,
      ],
    );
  }
}
