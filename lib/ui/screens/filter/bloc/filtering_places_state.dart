part of 'filtering_places_bloc.dart';

abstract class FilteringPlacesState extends Equatable {
  const FilteringPlacesState();
}

class FilteringPlacesInitial extends FilteringPlacesState {
  @override
  List<Object> get props => [];
}

class FilteringPlacesLoadInProgress extends FilteringPlacesState {
  @override
  List<Object> get props => [];
}

class FilteringPlacesLoadSuccess extends FilteringPlacesState {
  const FilteringPlacesLoadSuccess(this.places);

  final List<Place> places;

  @override
  List<Object?> get props => [places];
}
