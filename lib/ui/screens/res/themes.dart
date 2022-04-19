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

  // ignore: long-method
  static ThemeData _themeData(AppColors appColors) {
    return ThemeData(
      primaryColor: appColors.green,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      backgroundColor: appColors.backgroundSecondary,
      scaffoldBackgroundColor: appColors.background,
      cardColor: appColors.green,
      canvasColor: appColors.greenSurface,
      dialogBackgroundColor: appColors.blueSurface,
      iconTheme: IconThemeData(
        color: appColors.green,
      ),
      listTileTheme: ListTileThemeData(
        textColor: appColors.textLabel,
      ),
      dividerTheme: DividerThemeData(
        color: appColors.textLabelSecondary.withOpacity(0.4),
        thickness: 0.8,
        endIndent: 16,
        indent: 16,
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return appColors.backgroundSecondary;
            }

            return appColors.green;
          }),
          textStyle: MaterialStateProperty.resolveWith(
            (states) => TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith(
            (states) => Colors.black12.withOpacity(0.2),
          ),
          textStyle: MaterialStateProperty.resolveWith((states) =>
              TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
          elevation: MaterialStateProperty.resolveWith((states) => 0),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return appColors.backgroundSecondary;
            }

            return appColors.green;
          }),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
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
        bodyText2: TextStyle(color: appColors.textLabel, fontSize: 16),
        labelMedium: TextStyle(
          color: appColors.textLabelTertiary,
          fontSize: 16,
        ),
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
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          color: appColors.textLabel,
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: appColors.green,
        overlayColor: Colors.transparent,
        thumbColor: Colors.white,
        trackHeight: 2,
        minThumbSeparation: 20,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.green.withOpacity(0.4)),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: appColors.red.withOpacity(0.4), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.red.withOpacity(0.4)),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),
        errorStyle: TextStyle(height: 0),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: appColors.green.withOpacity(0.4), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(8)),
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
