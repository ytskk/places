part of 'add_sight_bloc.dart';

abstract class AddSightEvent extends Equatable {
  const AddSightEvent();
}

class AddSightNameChanged extends AddSightEvent {
  AddSightNameChanged(this.placeName);

  final String placeName;

  @override
  List<Object> get props => [placeName];
}

class AddSightCategoryChanged extends AddSightEvent {
  AddSightCategoryChanged(this.placeCategory);

  final PlaceCategory? placeCategory;

  @override
  List<Object> get props => [placeCategory ?? 0];
}

class AddSightCoordinateLatChanged extends AddSightEvent {
  AddSightCoordinateLatChanged(this.placeCoordinateLat);

  final String placeCoordinateLat;

  @override
  List<Object> get props => [placeCoordinateLat];
}

class AddSightCoordinateLngChanged extends AddSightEvent {
  AddSightCoordinateLngChanged(this.placeCoordinateLng);

  final String placeCoordinateLng;

  @override
  List<Object> get props => [placeCoordinateLng];
}

class AddSightDescriptionChanged extends AddSightEvent {
  AddSightDescriptionChanged(this.placeDescription);

  final String placeDescription;

  @override
  List<Object> get props => [placeDescription];
}

class AddSightSubmitted extends AddSightEvent {
  const AddSightSubmitted();

  @override
  List<Object> get props => [];
}
