import 'package:flutter/material.dart';
import '../widgets/background_animator.dart';
// animated loader not used on this screen
import '../utils/responsive.dart';
import 'verify_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_onPhoneChanged);
    // initialize validity state in case controller has prefilled text
    _onPhoneChanged();
  }

  void _onPhoneChanged() {
    final text = _phoneController.text.trim();
    final valid = _validatePhone(text);
    if (valid != _isValid) {
      setState(() => _isValid = valid);
    }
  }

  bool _validatePhone(String value) {
    if (value.isEmpty) return false;
    // Require a 10-digit mobile number. Allow optional country code or separators;
    // we strip non-digits and check for exactly 10 digits at the end.
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) return true;
    // If user included a country code like +91, allow total length 12 or 11
    // but ensure the last 10 digits represent the mobile number.
    if (digits.length > 10) {
      final last10 = digits.substring(digits.length - 10);
      return RegExp(r'^\d{10}\$').hasMatch(last10);
    }
    return false;
  }

  @override
  void dispose() {
    _phoneController.removeListener(_onPhoneChanged);
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // animated background
            Positioned.fill(child: BackgroundAnimator(frameDuration: const Duration(milliseconds: 400), expand: true, fit: BoxFit.cover)),

            // foreground content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.08),

                  Text(
                    'Sign in\nto continue',
                    style: TextStyle(fontSize: Responsive.scale(context, 44), fontWeight: FontWeight.w800, height: 1.02, color: Colors.black),
                  ),
                  SizedBox(height: Responsive.scale(context, 12)),
                  Text('Enter your mobile number to proceed', style: TextStyle(fontSize: Responsive.scale(context, 16), color: const Color(0xFF6D6D6D))),
                  SizedBox(height: Responsive.scale(context, 26)),

                  Text('Mobile Number', style: TextStyle(fontSize: Responsive.scale(context, 16), color: Colors.black87)),
                  SizedBox(height: Responsive.scale(context, 10)),
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'e.g. +91 9012XXXXXX',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: Colors.grey.shade300)),
                    ),
                  ),

                  SizedBox(height: Responsive.scale(context, 22)),
                  SizedBox(
                    width: double.infinity,
                    height: Responsive.scale(context, 58),
                    child: ElevatedButton(
                      onPressed: _isValid
                          ? () {
                              // navigate to Verify screen
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => VerifyScreen(phone: _phoneController.text.trim())),
                              );
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) return Colors.grey.shade300;
                          return const Color(0xFF1E77C9);
                        }),
                        foregroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) return Colors.grey.shade600;
                          return Colors.white;
                        }),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))),
                      ),
                      child: Text('Continue', style: TextStyle(fontSize: Responsive.scale(context, 18))),
                    ),
                  ),

                  const Spacer(),

                  Row(children: const [
                    Icon(Icons.info_outline, color: Color(0xFFB3B3B3)),
                    SizedBox(width: 12),
                    Expanded(child: Text('Your number stays private and is never shared', style: TextStyle(color: Color(0xFF8F8F8F)))),
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
