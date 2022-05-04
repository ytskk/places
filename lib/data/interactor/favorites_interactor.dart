import 'dart:developer';

import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/place_storage_repository.dart';

class FavoritesInteractor {
  FavoritesInteractor(this.repository);

  final PlaceStorageRepository repository;

  Future<List<Place>> getFavorites() async {
    return await repository.getFavorites();
  }

  Future<Place> getFavoriteById(Place place) async {
    return await repository.getFavorite(place);
  }

  Future<bool> isFavorite(Place place) async {
    return await repository.isFavorite(place);
  }

  Future<void> addFavorite(Place favorite) async {
    return await repository.addFavorite(favorite);
  }

  Future<void> removeFavorite(Place favorite) async {
    log('removeFavorite: $favorite');

    return await repository.removeFavorite(favorite);
  }

  Future<void> toggleFavorite(Place place) async {
    if (await repository.isFavorite(place)) {
      log('removing from favorites',
          name: 'FavoritesInteractor: toggleFavorite');

      return await repository.removeFavorite(place);
    }

    log('adding to favorites', name: 'FavoritesInteractor: toggleFavorite');

    return await repository.addFavorite(place);
  }

  Future<void> setPlannedAt(Place place, DateTime? plannedAt) async {
    if (plannedAt == null) {
      return;
    }

    return await repository.setPlannedAt(place, plannedAt);
  }
}
