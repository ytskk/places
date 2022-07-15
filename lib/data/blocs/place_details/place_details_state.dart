part of 'place_details_cubit.dart';

@immutable
abstract class PlaceDetailsState {}

class PlaceDetailsInitial extends PlaceDetailsState {}

class PlaceDetailsLoadInProgress extends PlaceDetailsState {}

class PlaceDetailsLoadSuccess extends PlaceDetailsState {
  final Place placeDetails;

  PlaceDetailsLoadSuccess(this.placeDetails);
}

class PlaceDetailsLoadFailure extends PlaceDetailsState {
  final Exception error;

  PlaceDetailsLoadFailure(this.error);
}
