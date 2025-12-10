import 'package:flutter/material.dart';
import 'package:image_sequence_animator/image_sequence_animator.dart';

class AnimatedLoader extends StatelessWidget {
  final double size;

  const AnimatedLoader({super.key, this.size = 64});

  @override
  Widget build(BuildContext context) {
    // Loader frames
    final loaderFrames = List<String>.generate(
      5,
      (i) => 'assets/loader/loader${i + 1}.png',
    );

    // Slow FPS to make transition smooth
    final fps = 2.0; // 3 frames per second → slow & smooth

    return SizedBox(
      width: size,
      height: size,
      child: ImageSequenceAnimator(
        '', // folder not used since we pass fullPaths
        '',
        1,
        loaderFrames.length,
        'png',
        loaderFrames.length.toDouble(),
        fullPaths: loaderFrames,
        fps: fps,
        isLooping: false,
        isAutoPlay: true,
      ),
    );
  }
}
