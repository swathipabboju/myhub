import 'package:flutter/material.dart';
import '../widgets/background_animator.dart';
import '../widgets/animated_loader.dart';
import '../utils/responsive.dart';
import 'signin_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: Stack(
          children: [
            // Background animator filling the whole screen (reusable)
            Positioned.fill(
              child: BackgroundAnimator(
                // uses default folderName 'assets/background' and bg1..bg4.png
                frameDuration: const Duration(milliseconds: 400),
                expand: true,
                fit: BoxFit.cover,
              ),
            ),

            // Foreground content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                children: [
                  // Spacer where artwork would sit
                  SizedBox(height: Responsive.hp(context, 0.52)),

                  // Title
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

                  // Subtitle lines
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Search smarter', style: TextStyle(fontSize: Responsive.scale(context, 18), color: const Color(0xFF6D6D6D))),
                        const SizedBox(height: 6),
                        Text('Order faster', style: TextStyle(fontSize: Responsive.scale(context, 18), color: const Color(0xFF6D6D6D))),
                        const SizedBox(height: 6),
                        Text('Book anything with AI', style: TextStyle(fontSize: Responsive.scale(context, 18), color: const Color(0xFF6D6D6D))),
                      ],
                    ),
                  ),

                  Spacer(),

                  // CTA button
                  SizedBox(
                    width: double.infinity,
                    height: Responsive.scale(context, 58),
                    child: ElevatedButton(
                      onPressed: () async {
                        // show full-screen loader dialog
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => Material(
                            color: Colors.transparent,
                            child: Center(
                              child: AnimatedLoader(fullScreen: true, frameDuration: const Duration(milliseconds: 200)),
                            ),
                          ),
                        );

                        // simulate loading time — wait until assets are visible then navigate
                        await Future.delayed(const Duration(milliseconds: 800));

                        // remove loader
                        if (Navigator.canPop(context)) Navigator.pop(context);

                        // navigate to sign-in screen
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const SignInScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E77C9),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                        elevation: 2,
                      ),
                      child: Text("Let's Go", style: TextStyle(fontSize: Responsive.scale(context, 18), color: Colors.white)),
                    ),
                  ),

                  SizedBox(height: Responsive.scale(context, 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

