import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/place_storage_repository.dart';

class FavoritesInteractor {
  FavoritesInteractor(this._repository);

  final PlaceStorageRepository _repository;

  Future<List<Place>> getFavorites() async {
    return await _repository.getFavorites();
  }

  Future<void> setPlannedAt(Place place, DateTime? plannedAt) async {
    _repository.setPlannedAt(place, plannedAt);
  }

  Future<bool> isFavorite(Place place) async {
    return await _repository.isFavorite(place);
  }

  Future<void> toggleFavorite(Place place) async {
    if (await _repository.isFavorite(place)) {
      removeFromFavorites(place);
      print('removing from favorites');

      return;
    }

    addToFavorites(place);
    print('adding to favorites');

    return;
  }

  Future<void> addToFavorites(Place place) async {
    _repository.addToFavorites(place);
  }

  Future<void> removeFromFavorites(Place place) async {
    _repository.removeFromFavorites(place);
  }
}
