import 'dart:async';

import 'package:dio/dio.dart';
import 'package:places/data/api/network_exception.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/place_network_repository.dart';
import 'package:places/data/repository/place_storage_repository.dart';
import 'package:places/models/places_filter_request_dto.dart';

abstract class PlaceInteractor {
  final PlaceNetworkRepository placeNetworkRepository;
  final PlaceStorageRepository placeStorageRepository;

  PlaceInteractor(this.placeNetworkRepository, this.placeStorageRepository);

  Future<List<Place>> getPlaces({
    required PlacesFilterRequestDto filterOptions,
    required double radiusFrom,
  });

  Future getPlaceDetails({required String id});

  Future searchPlace({required PlacesFilterRequestDto filterOptions});

  Future addPlace({required Place place});

  NetworkException handleError(DioError error);
}
