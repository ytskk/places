import 'dart:math';

import 'package:flutter/material.dart';

/// Returns range string from [RangeValues].
///
/// [units] — range units to display. Defaults to “км” kilometers.
///
/// ```
/// getRangeValuesString(RangeValues(10, 10000)) -> "От 1 до 10 км"
/// ```
String getRangeValuesString(RangeValues values, {String units = "км"}) {
  return "От ${max(1, values.start ~/ 1000)} до ${max(1, values.end ~/ 1000)} $units";
}
