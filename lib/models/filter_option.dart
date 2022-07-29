import 'dart:developer';

import 'package:places/models/sight.dart';

/// Class for describing and controls filter option.
class FilterOption {
  FilterOption({
    required this.category,
    this.isSelected = true,
  });

  final PlaceCategory category;
  final bool isSelected;

  FilterOption copyWith({
    PlaceCategory? category,
    bool? isSelected,
  }) {
    return FilterOption(
      category: category ?? this.category,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  FilterOption setSelected(bool newValue) {
    return copyWith(isSelected: newValue);
  }

  String get name => category.name;

  String get engName => category.engName;

  @override
  String toString() {
    return category.engName;
  }

  Map<String, dynamic> toJson() => {
        'category': category.toJson(),
        'isSelected': isSelected,
      };

  factory FilterOption.fromJson(Map<String, dynamic> json) {
    log('incoming json: $json', name: 'FilterOption.fromJson');

    return FilterOption(
      category: PlaceCategory.fromJson(json['category']['engName']),
      isSelected: json['isSelected'],
    );
  }
}
