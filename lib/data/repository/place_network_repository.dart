import 'dart:convert';

import 'package:places/data/api/api_constants.dart';
import 'package:places/data/api/client_api.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/models/places_filter_request_dto.dart';

/// Represents place network repository.
///
/// Inherits from interface [PlaceRepository].
///
/// Load data from network with [ClientApi].
class PlaceNetworkRepository implements PlaceRepository {
  final ClientApi clientApi;

  PlaceNetworkRepository(this.clientApi);

  /// Returns all places from network. Without filters.
  Future<List<Place>> getAllPlaces() async {
    final response = await clientApi.get(ApiConstants.placeUrl);

    final List<Place> places =
        response.data.map<Place>((json) => Place.fromJson(json)).toList();

    return places;
  }

  /// Returns place by id from network.
  ///
  /// TODO: handle id error.
  Future<Place> getPlaceById({required int id}) async {
    final response = await clientApi.get('${ApiConstants.placeUrl}/$id');

    return Place.fromJson(response.data);
  }

  /// Returns [PlaceDto] by filter with [PlacesFilterRequestDto].
  Future<List<PlaceDto>> getFilteredPlaces({
    required PlacesFilterRequestDto filterOptions,
  }) async {
    final String postBody = jsonEncode(filterOptions.toJson());

    final response =
        await clientApi.post(ApiConstants.filteredPlacesUrl, data: postBody);

    return response.data
        .map<PlaceDto>((json) => PlaceDto.fromJson(json))
        .toList();
  }

  Future<void> addNewPlace({required Place place}) async {
    final String postBody = jsonEncode(place.toJson());

    clientApi.post(ApiConstants.placeUrl, data: postBody);
  }
}
