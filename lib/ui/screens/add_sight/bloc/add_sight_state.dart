part of 'add_sight_bloc.dart';

class AddSightState extends Equatable {
  const AddSightState({
    this.status = FormzStatus.pure,
    this.placeName = const PlaceNameModel.pure(),
    this.placeCategory = const PlaceCategoryModel.pure(),
    this.placeCoordinateLat = const PlaceCoordinatesModel.pure(),
    this.placeCoordinateLng = const PlaceCoordinatesModel.pure(),
    this.placeDescription = const PlaceDescriptionModel.pure(),
    this.error,
    this.placeId,
    required this.formKey,
  });

  final FormzStatus status;
  final GlobalKey<FormState> formKey;
  final PlaceNameModel placeName;
  final PlaceCategoryModel placeCategory;
  final PlaceCoordinatesModel placeCoordinateLat;
  final PlaceCoordinatesModel placeCoordinateLng;
  final PlaceDescriptionModel placeDescription;
  final String? error;
  final String? placeId;

  AddSightState copyWith({
    FormzStatus? status,
    PlaceNameModel? placeName,
    PlaceCategoryModel? placeCategory,
    PlaceCoordinatesModel? placeCoordinateLat,
    PlaceCoordinatesModel? placeCoordinateLng,
    PlaceDescriptionModel? placeDescription,
    String? error,
    String? placeId,
  }) {
    return AddSightState(
      status: status ?? this.status,
      placeName: placeName ?? this.placeName,
      placeCategory: placeCategory ?? this.placeCategory,
      placeCoordinateLat: placeCoordinateLat ?? this.placeCoordinateLat,
      placeCoordinateLng: placeCoordinateLng ?? this.placeCoordinateLng,
      placeDescription: placeDescription ?? this.placeDescription,
      error: error ?? this.error,
      placeId: placeId ?? this.placeId,
      formKey: this.formKey,
    );
  }

  //to json
  Map<String, dynamic> toJson() => {
        'name': placeName.value,
        'placeType': placeCategory.value?.engName,
        'lat': double.parse(placeCoordinateLat.value),
        'lng': double.parse(placeCoordinateLng.value),
        if (placeDescription.value != null &&
            placeDescription.value!.isNotEmpty)
          'description': placeDescription.value,
      };

  @override
  List<Object?> get props => [
        status,
        placeName,
        placeCategory,
        placeCoordinateLat,
        placeCoordinateLng,
        placeDescription,
        error,
        placeId,
      ];
}
