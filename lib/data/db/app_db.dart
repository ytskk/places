import 'package:places/data/model/place_model.dart';
import 'package:places/models/sight.dart';

class AppDb {
  // # Favorites.

  // definitions
  List<Place> _favorites = [
    Place(
      id: 123,
      lat: 2.13,
      lng: 13.123,
      name: "name",
      urls: [""],
      type: SightCategories.cafe,
      description: "description",
    ),
    Place(
      id: 12312321,
      lat: 2.13,
      lng: 13.123,
      name: "Second",
      urls: [""],
      type: SightCategories.hotel,
      description: "description",
    ),
  ];

  bool _isDarkMode = true;

  bool _isFirstOpen = false;

  // getters
  List<Place> get favorites => _favorites;

  List<Place> get plannedPlaces => _favorites
    ..where((place) => place.plannedAt != null)
    ..toList();

  List<Place> get visitedPlaces => _favorites
    ..where((place) => place.visitedAt != null)
    ..toList();

  bool get isDarkMode => _isDarkMode;

  bool get isFirstOpen => _isFirstOpen;

  // setters
  void setDarkMode(bool value) {
    _isDarkMode = value;
  }

  // methods
  bool isFavorite(Place place) {
    // return _favorites.contains(place);
    return _favorites.indexWhere((element) => element.id == place.id) != -1;
  }

  void addFavorite(Place place) {
    _favorites.add(place);
    place.isFavorite = true;
  }

  void removeFavorite(Place place) {
    _favorites.removeWhere((element) => element.id == place.id);
    place.isFavorite = false;
  }

  void setPlannedAt(Place place, DateTime? plannedAt) {
    place.plannedAt = plannedAt;
  }

  Place getFavoriteById(int id) {
    return _favorites.firstWhere((element) => element.id == id);
  }
}
