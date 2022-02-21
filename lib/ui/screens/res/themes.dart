import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/ui/screens/res/styles.dart';

class AppThemeData {
  static final _themeBase = ThemeData(
    textTheme: TextTheme(
      headline2: headline2,
      headline4: headline4,
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: tabLabel,
      unselectedLabelStyle: TextStyle().copyWith(
        fontSize: 13,
      ),
      // indicator: BoxDecoration(),
    ),
  );

  static ThemeData _themeData(AppColors appColors) {
    return ThemeData(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      backgroundColor: appColors.background,
      scaffoldBackgroundColor: appColors.backgroundSecondary,
      cardColor: appColors.green,
      textTheme: TextTheme(
        bodyText1: TextStyle(color: appColors.textLabelSecondary),
        bodyText2: TextStyle(color: appColors.textLabel),
        headline2: headline2.copyWith(
          color: appColors.textLabel,
        ),
        headline3: headline3.copyWith(
          color: appColors.textLabel,
        ),
        headline4: headline4.copyWith(
          color: appColors.textLabel,
        ),
      ),
      tabBarTheme: _themeBase.tabBarTheme.copyWith(
        labelColor: appColors.fillColor,
        unselectedLabelColor: appColors.textLabelSecondary,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: appColors.textLabel,
        ),
      ),
    );
  }

  static ThemeData light() {
    return _themeData(AppColorsLight());
  }

  static ThemeData dark() {
    return _themeData(AppColorsDark());
  }

  static AppColors selectColor({isDark = false}) {
    return isDark ? AppColorsDark() : AppColorsLight();
  }
}
