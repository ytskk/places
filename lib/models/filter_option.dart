import 'dart:developer';

import 'package:places/models/sight.dart';

/// Class for describing and controls filter option.
class FilterOption {
  FilterOption({
    required this.category,
    bool isEnabled = true,
  }) : this._isSelected = isEnabled;

  final PlaceCategory category;
  bool _isSelected;

  void setSelected(bool value) {
    _isSelected = value;
    log(
      "$this is ${_isSelected ? "" : "un"}selected",
      name: 'FilterOption',
    );
  }

  bool get isSelected => _isSelected;

  String get name => category.name;

  String get engName => category.engName;

  @override
  String toString() {
    return category.engName;
  }
}
