part of 'places_bloc.dart';

abstract class PlacesEvent extends Equatable {
  const PlacesEvent();
}

class PlacesLoadInitial extends PlacesEvent {
  const PlacesLoadInitial();

  @override
  List<Object> get props => [];
}

class PlacesLoad extends PlacesEvent {
  final PlacesFilterRequestDto filterOptions;
  final double radiusFrom;

  const PlacesLoad({
    required this.filterOptions,
    required this.radiusFrom,
  });

  @override
  List<Object> get props => [filterOptions, radiusFrom];
}

class PlacesSet extends PlacesEvent {
  PlacesSet(this.places);

  final List<Place> places;

  @override
  List<Object?> get props => [places];
}
