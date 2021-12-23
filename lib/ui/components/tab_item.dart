import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';

class TabItem extends StatelessWidget {
  final bool isActive;
  final String text;

  const TabItem({Key? key, required this.isActive, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color? containerColor = isActive ? AppColors.whiteMain : null;
    Color textColor = isActive ? Colors.white : AppColors.whiteInactiveBlack;

    Widget result = Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );

    return result;
  }
}
