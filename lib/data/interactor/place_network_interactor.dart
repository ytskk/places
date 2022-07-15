import 'dart:async';

import 'package:dio/dio.dart';
import 'package:places/data/api/network_exception.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/models/places_filter_request_dto.dart';

class PlaceNetworkInteractor extends PlaceInteractor {
  PlaceNetworkInteractor(
    placeNetworkRepository,
    placeStorageRepository,
  ) : super(placeNetworkRepository, placeStorageRepository);

  /// Returns filtered with [radiusFrom] [radiusTo] and [types] places.
  ///
  /// Sorts by distance from [_coordinates].
  /// BUG: returns distance only if at least one type is provided.
  Future<List<Place>> getPlaces({
    required PlacesFilterRequestDto filterOptions,
    required double radiusFrom,
  }) async {
    try {
      final List<PlaceDto> places =
          await placeNetworkRepository.getFilteredPlaces(
        filterOptions: filterOptions,
      );

      // Exclude places with distance less than [radiusFrom].
      final radiusDependentPlaces = _excludeByRadius(places, radiusFrom);

      // Sort by distance ascending.
      final sortedPlaces = _sortByDistance(radiusDependentPlaces);

      // Convert [PlaceDto] to [Place] and return result.
      final convertedPlaces =
          sortedPlaces.map((place) => Place.fromDto(place)).toList();

      // Add favorites to places.
      final favoritesPlaces = await _fillFavorites(convertedPlaces);

      return favoritesPlaces;
    } on DioError catch (e) {
      final exception = placeNetworkRepository.handleError(e);

      throw exception;
    }
  }

  List<PlaceDto> _excludeByRadius(List<PlaceDto> places, double radius) {
    return places.where((place) => place.distance >= radius).toList();
  }

  List<PlaceDto> _sortByDistance(List<PlaceDto> places) {
    return places..sort((a, b) => a.distance.compareTo(b.distance));
  }

  Future getPlaceDetails({required String id}) async {
    final response = await placeNetworkRepository.getPlaceById(id: id);

    return response;
  }

  Future<List<Place>> _fillFavorites(List<Place> places) async {
    final favorites = await placeStorageRepository.getFavorites();

    return places.map((place) {
      place.isFavorite = favorites.contains(place.id);

      return place;
    }).toList();
  }

  @override
  Future searchPlace({required PlacesFilterRequestDto filterOptions}) {
    return placeNetworkRepository.getFilteredPlaces(
        filterOptions: filterOptions);
  }

  @override
  Future addPlace({required Place place}) async =>
      await placeNetworkRepository.addPlace(place: place);

  @override
  NetworkException handleError(DioError error) {
    return placeNetworkRepository.handleError(error);
  }
}
