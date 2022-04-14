import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';

/// A svg icon widget.
///
/// Example
/// ```
///   IconBox(
///     icon: AppIcons.calendar,
///     color: AppColors.whiteMain,
///   ),
/// ```
class IconBox extends StatelessWidget {
  /// Creates a fixed size box with provided svg icon (basically from [AppIcons]).
  ///
  /// The [size] is optional parameters can be null, defaults to [smallIconSize] lp.
  ///
  /// If [color] is null, uses default icon theme color.
  const IconBox({
    Key? key,
    required this.icon,
    this.color,
    this.size = smallIconSize,
  }) : super(key: key);

  final String icon;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final iconColor = color ?? Theme.of(context).iconTheme.color;

    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        icon,
        fit: BoxFit.contain,
        color: iconColor,
      ),
    );
  }
}
