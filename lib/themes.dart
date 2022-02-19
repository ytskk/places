import 'package:flutter/material.dart';
import 'package:places/styles.dart';

import 'domain/app_colors.dart';

final lightTheme = ThemeData(
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
  tabBarTheme: TabBarTheme(
    labelStyle: tabLabel,
    unselectedLabelColor: AppColors.textLabelSecondary,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: AppColors.textLabel,
    ),
  ),
);
