import 'package:flutter/widgets.dart';

/// Small responsive helpers used across screens to scale sizes and fonts
/// relative to a base design size (width: 375).
///
/// Usage:
/// - `Responsive.scale(context, 16)` scales a 16px value to the current screen width.
/// - `Responsive.wp(context, 0.5)` returns 50% of screen width.
class Responsive {
  static const double _baseWidth = 375.0;
  /// Scale a size (px) based on screen width relative to the base width.
  static double scale(BuildContext context, double size) {
    final w = MediaQuery.of(context).size.width;
    return size * (w / _baseWidth);
  }

  /// Percentage of screen width. Example: 0.5 -> 50% width.
  static double wp(BuildContext context, double percent) {
    return MediaQuery.of(context).size.width * percent;
  }

  /// Percentage of screen height. Example: 0.2 -> 20% height.
  static double hp(BuildContext context, double percent) {
    return MediaQuery.of(context).size.height * percent;
  }

  /// Convenience alias for font scaling (same as scale).
  static double font(BuildContext context, double fontSize) => scale(context, fontSize);
}
