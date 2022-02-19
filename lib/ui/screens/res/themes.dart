import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/styles.dart';

import '../../../domain/app_colors.dart';

final themeBase = ThemeData(
  tabBarTheme: TabBarTheme(
    labelStyle: tabLabel,
    indicator: BoxDecoration(),
  ),
);

final lightTheme = themeBase.copyWith(
  backgroundColor: AppColors.background,
  cardColor: AppColors.green,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: AppColors.textLabelSecondary),
    headline4: TextStyle(
      color: Colors.black,
    ),
  ),
  tabBarTheme: TabBarTheme(
    unselectedLabelColor: AppColorsDark.textLabelSecondary,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: AppColors.textLabel,
    ),
  ),
);

final darkTheme = themeBase.copyWith(
  scaffoldBackgroundColor: AppColorsDark.backgroundSecondary,
  backgroundColor: AppColorsDark.background,
  cardColor: AppColorsDark.green,
  textTheme: TextTheme(
    bodyText2: TextStyle(color: Colors.white),
    bodyText1: TextStyle(color: AppColorsDark.textLabelSecondary),
    headline4: TextStyle(
      color: Colors.white,
    ),
  ),
  tabBarTheme: themeBase.tabBarTheme.copyWith(
    labelColor: AppColorsDark.textLabel,
    unselectedLabelColor: AppColorsDark.textLabelSecondary,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: Colors.white,
    ),
  ),
);
