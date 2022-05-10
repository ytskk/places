import 'dart:async';

import 'package:dio/dio.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/place_network_repository.dart';
import 'package:places/data/repository/place_storage_repository.dart';
import 'package:places/models/coordinates.dart';
import 'package:places/models/places_filter_request_dto.dart';

class PlaceInteractor {
  final PlaceNetworkRepository _placeNetworkRepository;
  final PlaceStorageRepository _placeStorageRepository;

  final StreamController<List<Place>> _placesController =
      StreamController<List<Place>>.broadcast();

  /// Current user coordinates.
  ///
  /// TODO: replace with location request.
  static final Coordinates _coordinates = Coordinates(55.754093, 37.620407);

  PlaceInteractor(this._placeNetworkRepository, this._placeStorageRepository);

  Stream<List<Place>> get placesStream => _placesController.stream;

  void disposePlacesController() => _placesController.close();

  /// Returns filtered with [radiusFrom] [radiusTo] and [types] places.
  ///
  /// Sorts by distance from [_coordinates].
  /// BUG: returns distance only if at least one type is provided.
  Future<List<Place>> getPlaces({
    required double radiusTo,
    required double radiusFrom,
    List<String>? types,
  }) async {
    assert(radiusFrom <= radiusTo);

    try {
      final List<PlaceDto> places =
          await _placeNetworkRepository.getFilteredPlaces(
        filterOptions: PlacesFilterRequestDto(
          radius: radiusTo,
          lat: _coordinates.lat,
          lng: _coordinates.lon,
          typeFilter: types,
        ),
      );

      // Exclude places with distance less than [radiusFrom].
      final radiusDependentPlaces = _excludeByRadius(places, radiusFrom);

      // Add favorites to places.
      final favoritesPlaces = await _fillFavorites(radiusDependentPlaces);

      // Sort by distance ascending.
      final sortedPlaces = _sortByDistance(favoritesPlaces);

      // Convert [PlaceDto] to [Place] and return result.
      final convertedPlaces =
          sortedPlaces.map((place) => Place.fromDto(place)).toList();

      _placesController.sink.add(convertedPlaces);

      return convertedPlaces;
    } on DioError catch (e) {
      final exception = _placeNetworkRepository.handleError(e);
      _placesController.sink.addError(exception);

      throw exception;
    }
  }

  List<PlaceDto> _excludeByRadius(List<PlaceDto> places, double radius) {
    return places..where((place) => place.distance >= radius);
  }

  Future<List<PlaceDto>> _fillFavorites(List<PlaceDto> places) async {
    return await places
      ..map((place) async {
        place.isFavorite = await _placeStorageRepository.isFavorite(place);

        return place;
      });
  }

  List<PlaceDto> _sortByDistance(List<PlaceDto> places) {
    return places..sort((a, b) => a.distance.compareTo(b.distance));
  }

  Future getPlaceDetails({required int id}) async {
    final response = await _placeNetworkRepository.getPlaceById(id: id);

    final place = await _placeStorageRepository.getFavorite(response);

    return place;
  }
}