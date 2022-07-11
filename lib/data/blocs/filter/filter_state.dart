part of 'filter_cubit.dart';

class FilterState extends Equatable {
  FilterState({
    List<FilterOption>? filterOptions,
    RangeValues? radiusValues,
    RangeValues? initialRadiusValues,
  })  : filterOptions = filterOptions ??
            SightCategories.all
                .map((category) => FilterOption(category: category))
                .toList(),
        this.initialRadiusValues =
            initialRadiusValues ?? RangeValues(0, 100000),
        this.radiusValues =
            radiusValues ?? initialRadiusValues ?? RangeValues(0, 100000);

  final List<FilterOption> filterOptions;
  final RangeValues radiusValues;
  final RangeValues initialRadiusValues;

  List<String> getSelectedOptions() {
    return filterOptions
        .where((option) => option.isSelected)
        .map((option) => option.engName)
        .toList();
  }

  FilterState copyWith({
    List<FilterOption>? filterOptions,
    RangeValues? radiusValues,
  }) {
    return FilterState(
      filterOptions: filterOptions ?? this.filterOptions,
      radiusValues: radiusValues ?? this.radiusValues,
    );
  }

  @override
  List<Object?> get props => [
        filterOptions,
        radiusValues,
        initialRadiusValues,
      ];
}
