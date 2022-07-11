part of 'filtering_places_bloc.dart';

abstract class FilteringPlacesEvent extends Equatable {
  const FilteringPlacesEvent();
}

class FilteringPlacesLoad extends FilteringPlacesEvent {
  final double radiusFrom;
  final double radiusTo;
  final List<String> selectedOptions;

  const FilteringPlacesLoad({
    required this.radiusFrom,
    required this.radiusTo,
    required this.selectedOptions,
  });

  @override
  List<Object> get props => [
        radiusFrom,
        radiusTo,
        selectedOptions,
      ];
}
