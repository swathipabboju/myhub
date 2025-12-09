import 'package:flutter/material.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

/// A reusable background animator that plays an image sequence.

class BackgroundAnimator extends StatelessWidget {
  final List<String>? fullPaths;
  final String folderName;
  final String fileName;
  final int suffixStart;
  final int suffixCount;
  final String fileFormat;
  final int frameCount;
  final Duration frameDuration;
  final bool isLooping;
  final bool isAutoPlay;
  final BoxFit fit;
  final bool expand; // whether to expand to fill parent

  const BackgroundAnimator({
    Key? key,
    this.fullPaths,
    this.folderName = 'assets/background',
    this.fileName = 'bg',
    this.suffixStart = 1,
    this.suffixCount = 1,
    this.fileFormat = 'png',
    this.frameCount = 4,
    this.frameDuration = const Duration(milliseconds: 400),
    this.isLooping = true,
    this.isAutoPlay = true,
    this.fit = BoxFit.cover,
    this.expand = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ms = frameDuration.inMilliseconds > 0 ? frameDuration.inMilliseconds : 100;
    final fps = 1000.0 / ms;

    final animator = ImageSequenceAnimator(
      folderName,
      fileName,
      suffixStart,
      suffixCount,
      fileFormat,
      frameCount.toDouble(),
      fullPaths: fullPaths,
      fps: fps,
      isLooping: isLooping,
      isAutoPlay: isAutoPlay,
    );

    Widget child = animator;

    // If expand is true, scale the animator to cover its parent area.
    if (expand) {
      child = SizedBox.expand(
        child: FittedBox(
          fit: fit,
          alignment: Alignment.center,
          child: SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height, child: animator),
        ),
      );
    } else {
      child = FittedBox(fit: fit, alignment: Alignment.center, child: animator);
    }

    return child;
  }
}
