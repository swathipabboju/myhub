import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widgets/background_animator.dart';
import '../utils/responsive.dart';
import 'myhub_home.dart';

class VerifyScreen extends StatefulWidget {
  final String phone;
  const VerifyScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) FocusScope.of(context).requestFocus(_focusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    for (final f in _focusNodes) f.dispose();
    super.dispose();
  }

  String _currentOtp() => _controllers.map((c) => c.text).join();
  bool get _isValid => _currentOtp().replaceAll(RegExp(r'\D'), '').length == 6;

  void _onDigitChanged(String value, int index) {
    if (value.length > 1) {
      final chars = value.replaceAll(RegExp(r'\D'), '').split('');
      for (
        var i = 0;
        i < chars.length && index + i < _controllers.length;
        i++
      ) {
        _controllers[index + i].text = chars[i];
      }
      final next = index + chars.length;
      if (next < _focusNodes.length) {
        FocusScope.of(context).requestFocus(_focusNodes[next]);
      } else {
        FocusScope.of(context).unfocus();
      }
      setState(() {});
      return;
    }

    if (value.isNotEmpty) {
      final next = index + 1;
      if (next < _focusNodes.length)
        FocusScope.of(context).requestFocus(_focusNodes[next]);
    } else {
      final prev = index - 1;
      if (prev >= 0) FocusScope.of(context).requestFocus(_focusNodes[prev]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    const horizontalPadding = 24.0;

    final availableWidth = mq.size.width - horizontalPadding * 2;
    final gap = max(8.0, Responsive.scale(context, 10));
    final fieldSize = min(
      Responsive.scale(context, 56),
      (availableWidth - gap * 5) / 6,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            const Positioned.fill(
              child: BackgroundAnimator(
                frameDuration: Duration(milliseconds: 400),
                expand: true,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 20.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: mq.size.height - mq.padding.vertical - 40,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Responsive.hp(context, 0.05)),
                          Text(
                            'Verify\nyour number',
                            style: TextStyle(
                              fontSize: Responsive.scale(context, 44),
                              fontWeight: FontWeight.w800,
                              height: 1.02,
                            ),
                          ),
                          SizedBox(height: Responsive.scale(context, 12)),
                          Text(
                            "We've sent a 6-digit code to ${widget.phone}",
                            style: TextStyle(
                              fontSize: Responsive.scale(context, 16),
                              color: const Color(0xFF6D6D6D),
                            ),
                          ),

                          const SizedBox(height: 28),

                          Center(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(6, (i) {
                                    return Flexible(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: gap / 2,
                                        ),
                                        width: fieldSize,
                                        height: fieldSize,
                                        child: TextField(
                                          controller: _controllers[i],
                                          focusNode: _focusNodes[i],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          style: TextStyle(
                                            fontSize: Responsive.scale(
                                              context,
                                              20,
                                            ),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          decoration: InputDecoration(
                                            counterText: '',
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding: EdgeInsets.zero,
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                12,
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                          ),
                                          onChanged: (v) => _onDigitChanged(v, i),
                                        ),
                                      ),
                                    );
                                  }),
                                ),

                                SizedBox(height: Responsive.scale(context, 12)),
                                Text(
                                  'Enter the code you received via SMS',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: Responsive.scale(context, 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: Responsive.scale(context, 58),
                            child: ElevatedButton(
                              onPressed: _isValid
                                  ? () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) =>  MyHubHome(),
                                        ),
                                      );
                                    }
                                  : null,
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                      (states) =>
                                          states.contains(
                                            MaterialState.disabled,
                                          )
                                          ? Colors.grey.shade300
                                          : const Color(0xFF1E77C9),
                                    ),
                                foregroundColor:
                                    MaterialStateProperty.resolveWith(
                                      (states) =>
                                          states.contains(
                                            MaterialState.disabled,
                                          )
                                          ? Colors.grey.shade600
                                          : Colors.white,
                                    ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                'Verify',
                                style: TextStyle(
                                  fontSize: Responsive.scale(context, 18),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Center(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: Responsive.scale(context, 14),
                                ),
                                children: [
                                  const TextSpan(text: "Didn't get the code? "),
                                  TextSpan(
                                    text: 'Resend OTP',
                                    style: const TextStyle(
                                      color: Color(0xFF1E77C9),
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {},
                                  ),
                                  TextSpan(
                                    text: ' (after 30s)',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
