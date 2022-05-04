import 'package:places/data/db/app_db.dart';
import 'package:places/data/model/place_model.dart';

class PlaceStorageRepository {
  final AppDb _appDb;

  PlaceStorageRepository(this._appDb);

  Future<List<Place>> getFavorites() async {
    // await Future.delayed(Duration(milliseconds: 400));

    return _appDb.favorites;
  }

  Future<bool> isFavorite(Place place) async {
    return await _appDb.isFavorite(place);
  }

  Future<void> addFavorite(Place place) async {
    await Future.delayed(Duration(milliseconds: 400));

    _appDb.addFavorite(place);
  }

  Future<void> removeFavorite(Place place) async {
    await Future.delayed(Duration(milliseconds: 400));

    _appDb.removeFavorite(place);
  }

  Future<void> setPlannedAt(Place place, DateTime? dateTime) async {
    await Future.delayed(Duration(milliseconds: 400));

    _appDb.setPlannedAt(place, dateTime);
  }

  Future<Place> getFavorite(Place place) async {
    if (!await isFavorite(place)) {
      return place;
    }

    return await _appDb.getFavoriteById(place.id);
  }
}
