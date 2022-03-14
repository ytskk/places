import 'package:flutter/cupertino.dart';

class AppColors {
  late final Color fillColor;
  late final Color textLabel;
  late final Color textLabelSecondary;
  late final Color background;
  late final Color backgroundSecondary;
  late final Color green;
  late final Color greenSurface;
  late final Color blueSurface;
  late final Color red;
}

class AppColorsLight extends AppColors {
  final Color fillColor = Color(0xffffffff);
  final Color textLabel = Color(0xff252849);
  final Color textLabelSecondary = Color.fromRGBO(134, 136, 156, 0.96);
  final Color backgroundSecondary = Color(0xffF5F5F5);
  final Color background = Color(0xffffffff);
  final Color green = Color(0xff4caf50);
  final Color greenSurface = Color(0xFFD9ECDA);
  final Color blueSurface = Color(0xff252849);
  final Color red = CupertinoColors.destructiveRed;
}

class AppColorsDark extends AppColors {
  final Color fillColor = Color(0xff000000);
  final Color textLabel = Color(0xffffffff);
  final Color textLabelSecondary = Color(0xff7C7E92);
  final Color background = Color(0xff1A1A20);
  final Color backgroundSecondary = Color(0xff21222C);
  final Color green = Color(0xff6ADA6F);
  final Color greenSurface = Color(0xFF2F362F);
  final Color blueSurface = Color(0xff373f8e);
  final Color red = CupertinoColors.destructiveRed;
}
