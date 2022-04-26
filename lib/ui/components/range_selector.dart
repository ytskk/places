import 'package:flutter/material.dart';

/// A custom [RangeSlider]
class RangeSelector extends StatefulWidget {
  const RangeSelector({
    Key? key,
    this.onChanged,
    required this.initialRangeValues,
    required this.values,
    this.onChangeEnd,
  }) : super(key: key);

  /// Min and max values of slider.
  final RangeValues initialRangeValues;

  /// Current slider values.
  final RangeValues values;
  final ValueChanged<RangeValues>? onChanged;

  final ValueChanged<RangeValues>? onChangeEnd;

  @override
  _RangeSelectorState createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  @override
  Widget build(BuildContext context) {
    return RangeSlider(
      min: widget.initialRangeValues.start,
      max: widget.initialRangeValues.end,
      values: widget.values,
      onChanged: widget.onChanged,
      onChangeEnd: widget.onChangeEnd,
    );
  }
}
