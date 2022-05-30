import 'package:places/data/db/app_db.dart';
import 'package:places/data/model/place_model.dart';

class PlaceStorageRepository {
  PlaceStorageRepository(this._appDb);

  final AppDb _appDb;

  Future<List<Place>> getFavorites() async {
    await Future.delayed(Duration(milliseconds: 400));

    return _appDb.favorites;
  }

  Future<void> setPlannedAt(Place place, DateTime? plannedAt) async {
    _appDb.setPlannedAt(place, plannedAt);
  }

  Future<bool> isFavorite(Place place) async {
    return await _appDb.isFavorite(place);
  }

  Future<void> addToFavorites(Place place) async {
    _appDb.addFavorite(place);
  }

  Future<void> removeFromFavorites(Place place) async {
    _appDb.removeFavorite(place);
  }
}
