import 'package:flutter/material.dart';

/// The default brand gradient for the application.
const brandGradient = const LinearGradient(
  begin: Alignment(-2.2, 0),
  end: Alignment(1, 0),
  colors: [Color(0xffFCDD3D), Color(0xff4CAF50)],
);

const EdgeInsets mediumWrappingPadding = const EdgeInsets.symmetric(
  horizontal: 16.0,
  vertical: 8.0,
);

const EdgeInsets largeWrappingPadding = const EdgeInsets.symmetric(
  horizontal: 16.0,
  vertical: 24.0,
);

const double maxBoxWidth = 360.0;

const double smallIconSize = 24.0;

const double smallSpacing = 8.0;
const double mediumSpacing = 16.0;
const double largeSpacing = 24.0;

const double smallBorderRadius = 12.0;
const double mediumBorderRadius = 16.0;
const double largeBorderRadius = 24.0;

const double bottomAppBarHeight = 52.0;
const double largeLeadingWidth = 80.0;

// Most relevant Date formats.
class DateFormats {
  DateFormats._();

  static const String dayShortMonthYearDateFormat = 'd MMM, yyyy';
}
