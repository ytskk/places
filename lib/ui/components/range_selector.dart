import 'package:flutter/material.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:provider/provider.dart';

class RangeSelector extends StatefulWidget {
  final RangeValues rangeValues;
  final RangeValues values;
  final void Function(RangeValues) onChanged;

  const RangeSelector({
    Key? key,
    required RangeValues this.rangeValues,
    required void Function(RangeValues) this.onChanged,
    required RangeValues this.values,
  }) : super(key: key);

  @override
  _RangeSelectorState createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  @override
  Widget build(BuildContext context) {
    // RangeValues _searchDistanceValues = context.watch<Filter>().rangeValues;

    return RangeSlider(
      min: widget.rangeValues.start,
      max: widget.rangeValues.end,
      values: widget.values,
      onChanged: (newValue) {
        context.read<Filter>().setRangeValues(newValue);
      },
    );
  }
}
