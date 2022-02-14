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
class IconContainer extends StatelessWidget {
  final String icon;
  final Color? color;
  final double width;
  final double height;

  /// Creates a fixed size box with provided svg icon.
  /// The [width] and [height] is optional parameters can be null.
  ///
  /// Default `color` [Colors.white]
  const IconContainer({
    Key? key,
    required this.icon,
    this.color,
    this.width = 24,
    this.height = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.contain,
        color: color,
      ),
    );
  }
}