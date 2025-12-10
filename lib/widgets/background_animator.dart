import 'package:flutter/material.dart';

class BackgroundAnimator extends StatefulWidget {
  const BackgroundAnimator({super.key});

  @override
  State<BackgroundAnimator> createState() => _BackgroundAnimatorState();
}

class _BackgroundAnimatorState extends State<BackgroundAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> frames = [
    "assets/background/bg1.png",
    "assets/background/bg2.png",
    "assets/background/bg3.png",
    "assets/background/bg4.png",
  ];

  int currentIndex = 0;
  int nextIndex = 1;

  @override
  void initState() {
    super.initState();

    // Initialize controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), // slow & smooth
    );

    // Fade animation
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Loop animation
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          currentIndex = nextIndex;
          nextIndex = (nextIndex + 1) % frames.length;
        });
        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(frames[currentIndex], fit: BoxFit.cover),
            Opacity(
              opacity: _animation.value,
              child: Image.asset(frames[nextIndex], fit: BoxFit.cover),
            ),
          ],
        );
      },
    );
  }
}
