import 'dart:convert';

import 'package:places/data/api/api_constants.dart';
import 'package:places/data/api/client_api.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/models/places_filter_request_dto.dart';

class PlaceNetworkRepository extends PlaceRepository {
  final ClientApi clientApi = ClientApi();

  @override
  Future<List<Place>> getAllPlaces() async {
    final response = await clientApi.get(ApiConstants.placeUrl);

    final List<Place> places =
        response.data.map<Place>((json) => Place.fromJson(json)).toList();

    return places;
  }

  @override
  Future<Place> getPlaceById({required int id}) async {
    final response = await clientApi.get('${ApiConstants.placeUrl}/$id');

    return Place.fromJson(response.data);
  }

  @override
  Future<List<PlaceDto>> getFilteredPlaces(
      {required PlacesFilterRequestDto filterOptions}) async {
    final String postBody = jsonEncode(filterOptions.toJson());

    final response =
        await clientApi.post(ApiConstants.filteredPlacesUrl, data: postBody);

    return response.data
        .map<PlaceDto>((json) => PlaceDto.fromJson(json))
        .toList();
  }
}
