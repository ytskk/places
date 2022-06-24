import 'dart:async';

import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/place_network_repository.dart';
import 'package:places/data/repository/place_storage_repository.dart';
import 'package:places/models/places_filter_request_dto.dart';

abstract class PlaceInteractor {
  final PlaceNetworkRepository placeNetworkRepository;
  final PlaceStorageRepository placeStorageRepository;

  PlaceInteractor(this.placeNetworkRepository, this.placeStorageRepository);

  Future<List<Place>> getPlaces({
    required double radiusTo,
    required double radiusFrom,
    List<String>? types,
  });

  Future getPlaceDetails({required int id});

  Future searchPlace({required PlacesFilterRequestDto filterOptions});

  Future addPlace({required Place place});
}
