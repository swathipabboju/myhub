import 'package:flutter/material.dart';
import '../widgets/background_animator.dart';
import '../widgets/animated_loader.dart';
import '../utils/responsive.dart';
import 'signin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isLoading = false;

  void _onLetsGoPressed() async {
    setState(() {
      isLoading = true; // Show loader
    });

    // Simulate loading time
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Navigate to SignInScreen after loader
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background animator filling the whole screen
          Positioned.fill(
            child: BackgroundAnimator(
              frameDuration: const Duration(milliseconds: 400),
              expand: true,
              fit: BoxFit.cover,
            ),
          ),

          // Foreground content
          SafeArea(
            bottom: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  SizedBox(height: Responsive.hp(context, 0.52)),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Experience\nthe Next Gen',
                      style: TextStyle(
                        fontSize: Responsive.scale(context, 44),
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        height: 1.02,
                      ),
                    ),
                  ),

                  SizedBox(height: Responsive.scale(context, 18)),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Search smarter',
                          style: TextStyle(
                            fontSize: Responsive.scale(context, 18),
                            color: const Color(0xFF6D6D6D),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Order faster',
                          style: TextStyle(
                            fontSize: Responsive.scale(context, 18),
                            color: const Color(0xFF6D6D6D),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Book anything with AI',
                          style: TextStyle(
                            fontSize: Responsive.scale(context, 18),
                            color: const Color(0xFF6D6D6D),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  SizedBox(
                    width: double.infinity,
                    height: Responsive.scale(context, 58),
                    child: ElevatedButton(
                      onPressed: _onLetsGoPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E77C9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        "Let's Go",
                        style: TextStyle(
                          fontSize: Responsive.scale(context, 18),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Responsive.scale(context, 18)),
                ],
              ),
            ),
          ),

          // Full-screen loader overlay
          if (isLoading)
            Positioned.fill(
              child: AnimatedLoader(
                fullScreen: true,
                frameDuration: const Duration(milliseconds: 500),
              ),
            ),
        ],
      ),
    );
  }
}
