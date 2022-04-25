import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/models/filter_option.dart';
import 'package:places/models/sight.dart';

class Filter extends ChangeNotifier {
  List<FilterOption> _filterOptions =
      filterCategories.map((category) => FilterOption(name: category)).toList();

  /// TMP: initial value to mocks.
  final List<Sight> _nearbyPlaces = [...mocks];

  List<Sight> get nearbyPlaces => _nearbyPlaces;

  void setNearbyPlaces(List<Sight> sights) {
    _nearbyPlaces
      ..clear()
      ..addAll(sights);
    notifyListeners();
  }

  final double _rangeValueStart = 10000;
  final double _rangeValueEnd = 30000;
  RangeValues _rangeValues = RangeValues(10000, 30000);

  RangeValues get rangeValues => _rangeValues;

  void setRangeValues(RangeValues values) {
    _rangeValues = values;
    notifyListeners();
  }

  List<FilterOption> get filterOptions => _filterOptions;

  List get selectedOptions =>
      _filterOptions.where((option) => option.isSelected).toList();

  List get selectedCategories =>
      selectedOptions.map((category) => category.nameFilter).toList();

  void clearFilterOptions() {
    _filterOptions.forEach((category) {
      category.setSelected(true);
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
