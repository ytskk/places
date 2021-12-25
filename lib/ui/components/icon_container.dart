import 'package:flutter/material.dart';

class IconContainer extends StatelessWidget {
  final String icon;
  final Color? color;
  final double width;
  final double height;

  /// Container with provided icon.
  ///
  /// icon - assets icon name.
  const IconContainer({
    Key? key,
    required this.icon,
    this.color,
    this.width = 24,
    this.height = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('icon: $icon');

    return Container(
      width: width,
      height: height,
      // color: Colors.red.shade400,
      child: Image.asset(
        icon,
        fit: BoxFit.contain,
        color: color,
      ),
    );
  }
}
