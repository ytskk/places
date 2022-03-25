import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/models/filter_option.dart';

class Filter extends ChangeNotifier {
  // fill from mock data
  List<FilterOption> _filterOptions =
      filterCategories.map((category) => FilterOption(name: category)).toList();

  final double _rangeValueStart = 100;
  final double _rangeValueEnd = 10000;
  RangeValues _rangeValues = RangeValues(100, 10000);

  RangeValues get rangeValues => _rangeValues;

  void setRangeValues(RangeValues values) {
    _rangeValues = values;
    notifyListeners();
  }

  List<FilterOption> get filterOptions => _filterOptions;

  List get selectedOptions =>
      _filterOptions.where((option) => option.isSelected).toList();

  List get selectedCategories =>
      selectedOptions.map((category) => category.name).toList();

  void clearFilterOptions() {
    _filterOptions.forEach((category) {
      category.setSelected(false);
    });
    log("Selected options: ${selectedOptions}");
    _rangeValues = RangeValues(_rangeValueStart, _rangeValueEnd);
    notifyListeners();
  }

  void toggleCategory(FilterOption category) {
    category.setSelected(!category.isSelected);
    log("Selected options: ${selectedOptions}");
    notifyListeners();
  }
}
