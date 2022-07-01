part of 'places_bloc.dart';

abstract class PlacesState extends Equatable {
  const PlacesState();
}

class PlacesInitial extends PlacesState {
  @override
  List<Object> get props => [];
}

class PlacesLoadInProgress extends PlacesState {
  @override
  List<Object> get props => [];
}

class PlacesLoadSuccess extends PlacesState {
  final List<Place> places;

  const PlacesLoadSuccess(this.places);

  @override
  List<Object> get props => [places];
}

class PlacesLoadFailure extends PlacesState {
  final NetworkException error;

  const PlacesLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
