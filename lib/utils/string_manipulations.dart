import 'package:flutter/material.dart';

/// Returns range string from [RangeValues] with rounding to 100.
///
/// **Arguments**
/// - units — range units to display.
///
/// Example
/// ```dart
/// getRangeValuesString(RangeValues(10, 10000)) -> "От 10м 10000до м"
/// ```
String getRangeValuesString(RangeValues values, {String units = "м"}) {
  return "От ${values.start ~/ 100 * 100}$units до ${values.end ~/ 100 * 100}$units";
}
