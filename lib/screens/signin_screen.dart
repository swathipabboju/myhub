import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/background_animator.dart';
import '../utils/responsive.dart';
import 'verify_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

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
    _onPhoneChanged(); // initial validation
  }

  void _onPhoneChanged() {
    final text = _phoneController.text.trim();
    final valid = _validatePhone(text);
    if (valid != _isValid) {
      setState(() => _isValid = valid);
    }
  }

  bool _validatePhone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length == 10) return true;

    if (digits.length > 10) {
      final last10 = digits.substring(digits.length - 10);
      return RegExp(r'^\d{10}$').hasMatch(last10);
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
    final media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // full screen background
          Positioned.fill(child: BackgroundAnimator()),

          // scrollable content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: media.height),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: media.height * 0.08),

                      Text(
                        'Sign in\nto continue',
                        style: TextStyle(
                          fontSize: Responsive.scale(context, 44),
                          fontWeight: FontWeight.w800,
                          height: 1.02,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: Responsive.scale(context, 12)),
                      Text(
                        'Enter your mobile number to proceed',
                        style: TextStyle(
                          fontSize: Responsive.scale(context, 16),
                          color: const Color(0xFF6D6D6D),
                        ),
                      ),

                      SizedBox(height: Responsive.scale(context, 26)),

                      Text(
                        'Mobile Number',
                        style: TextStyle(
                          fontSize: Responsive.scale(context, 16),
                          color: Colors.black87,
                        ),
                      ),

                      SizedBox(height: Responsive.scale(context, 10)),

                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          hintText: 'e.g. 9012XXXXXX',
                          counterText: "",
                          hintStyle: TextStyle(color: Colors.grey.shade400),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),

                      SizedBox(height: Responsive.scale(context, 22)),

                      SizedBox(
                        width: double.infinity,
                        height: Responsive.scale(context, 58),
                        child: ElevatedButton(
                          onPressed: _isValid
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => VerifyScreen(
                                        phone: _phoneController.text.trim(),
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey.shade300;
                              }
                              return const Color(0xFF1E77C9);
                            }),
                            foregroundColor: MaterialStateProperty.resolveWith((
                              states,
                            ) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey.shade600;
                              }
                              return Colors.white;
                            }),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: Responsive.scale(context, 18),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: Responsive.scale(context, 40)),

                      Row(
                        children: const [
                          Icon(Icons.info_outline, color: Color(0xFFB3B3B3)),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Your number stays private and is never shared',
                              style: TextStyle(color: Color(0xFF8F8F8F)),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
