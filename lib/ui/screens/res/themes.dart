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
      primaryColor: appColors.green,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      backgroundColor: appColors.backgroundSecondary,
      scaffoldBackgroundColor: appColors.background,
      cardColor: appColors.green,
      canvasColor: appColors.greenOnSurface,
      iconTheme: IconThemeData(
        color: appColors.green,
      ),
      listTileTheme: ListTileThemeData(
        textColor: appColors.textLabel,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.resolveWith((states) =>
              TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
          elevation: MaterialStateProperty.resolveWith((states) => 0),
          backgroundColor:
              MaterialStateProperty.resolveWith((states) => appColors.green),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.all(16),
          ),
        ),
      ),
      textTheme: TextTheme(
        caption: ThemeData().textTheme.caption!.copyWith(
              fontSize: 11,
              color: appColors.textLabelSecondary,
            ),
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
      sliderTheme: SliderThemeData(
        activeTrackColor: appColors.green,
        overlayColor: Colors.transparent,
        thumbColor: appColors.backgroundSecondary,
        trackHeight: 2,
        minThumbSeparation: 20,
      ),
    );
  }

  static ThemeData light() {
    return _themeData(AppColorsLight());
  }

  static ThemeData dark() {
    return _themeData(AppColorsDark());
  }

  /**
   * Returns theme-based color from [AppColors]
   * 
   * **Attributes**
   * - `isDark` — controls theme (light or dark). Default false.
   */
  static AppColors selectColor({isDark = false}) {
    return isDark ? AppColorsDark() : AppColorsLight();
  }
}
