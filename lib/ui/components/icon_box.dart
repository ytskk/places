import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Creates a fixed size box with provided svg icon.
/// The [width] and [height] parameters can be null.
///
/// icon - assets icon name, provided by [AppIcons].
///
/// Example
/// ```
///   IconContainer(
///     icon: AppIcons.calendar,
///     color: AppColors.whiteMain,
///   ),
/// ```
class IconBox extends StatelessWidget {
  final String icon;
  final Color? color;
  final double size;

  /// Creates a fixed size box with provided svg icon.
  /// The [width] and [height] is optional parameters can be null.
  ///
  /// Default `color` [Colors.white]
  const IconBox({
    Key? key,
    required this.icon,
    this.color,
    this.size = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.contain,
        color: color,
      ),
    );
  }
}
