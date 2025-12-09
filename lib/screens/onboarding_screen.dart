import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [
              // Artwork area
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.52,
                child: Stack(
                  children: [
                    // Top-right large soft circle
                    Positioned(
                      right: -width * 0.08,
                      top: -24,
                      child: Container(
                        width: width * 0.7,
                        height: width * 0.7,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.blue.shade200.withOpacity(0.95),
                              Colors.blue.shade100.withOpacity(0.25),
                              Colors.transparent,
                            ],
                            center: const Alignment(-0.2, -0.2),
                            radius: 0.9,
                          ),
                        ),
                      ),
                    ),

                    // Vertical streaks (decorative)
                    Positioned(
                      right: width * 0.08,
                      top: 60,
                      bottom: 40,
                      width: 72,
                      child: Opacity(
                        opacity: 0.22,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.blue.shade200,
                                Colors.blue.shade50,
                                Colors.white,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Bottom-left subtle circle
                    Positioned(
                      left: -40,
                      bottom: 36,
                      child: Container(
                        width: width * 0.45,
                        height: width * 0.45,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue.shade50.withOpacity(0.9),
                        ),
                      ),
                    ),

                    // Rounded device corner mask (optional) - top-left rounded overlay to mimic attachment
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(),
                      ),
                    ),
                  ],
                ),
              ),

              // Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Experience\nthe Next Gen',
                  style: TextStyle(
                    fontSize: 44,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    height: 1.02,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Subtitle lines
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Search smarter', style: TextStyle(fontSize: 18, color: Color(0xFF6D6D6D))),
                    SizedBox(height: 6),
                    Text('Order faster', style: TextStyle(fontSize: 18, color: Color(0xFF6D6D6D))),
                    SizedBox(height: 6),
                    Text('Book anything with AI', style: TextStyle(fontSize: 18, color: Color(0xFF6D6D6D))),
                  ],
                ),
              ),

              const Spacer(),

              // CTA button
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: hook up navigation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E77C9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                    elevation: 2,
                  ),
                  child: const Text("Let's Go", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
