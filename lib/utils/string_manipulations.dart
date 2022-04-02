import 'package:flutter/material.dart';

/// Returns range string from [RangeValues] with rounding to 100.
///
/// [units] — range units to display. Defaults to “m” meters.
///
/// ```
/// getRangeValuesString(RangeValues(10, 10000)) -> "От 10м 10000до м"
/// ```
String getRangeValuesString(RangeValues values, {String units = "м"}) {
  return "От ${values.start ~/ 100 * 100}$units до ${values.end ~/ 100 * 100}$units";
}
