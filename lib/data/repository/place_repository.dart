import 'package:places/data/model/place_model.dart';
import 'package:places/models/places_filter_request_dto.dart';

abstract class PlaceRepository {
  Future<List<Place>> getAllPlaces();

  Future<List<PlaceDto>> getFilteredPlaces({
    required PlacesFilterRequestDto filterOptions,
  });

  Future<Place> getPlaceById({
    required String id,
  });

  Future<void> addPlace({
    required Place place,
  });
}
