import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';

class AppDb extends ChangeNotifier {
  // # Favorites.

  // definitions
  List<Place> _favorites = [];

  bool _isDarkMode = false;

  // getters
  List<Place> get favorites => _favorites;

  List<Place> get plannedPlaces => _favorites
    ..where((place) => place.plannedAt != null)
    ..toList();

  List<Place> get visitedPlaces => _favorites
    ..where((place) => place.visitedAt != null)
    ..toList();

  bool get isDarkMode => _isDarkMode;

  // setters
  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }

  // methods
  bool isFavorite(Place place) {
    // return _favorites.contains(place);
    return _favorites.indexWhere((element) => element.id == place.id) != -1;
  }

  void addFavorite(Place place) {
    _favorites.add(place);
    place.isFavorite = true;
    notifyListeners();
  }

  void removeFavorite(Place place) {
    _favorites.removeWhere((element) => element.id == place.id);
    place.isFavorite = false;
    notifyListeners();
  }

  void setPlannedAt(Place place, DateTime? plannedAt) {
    place.plannedAt = plannedAt;
    notifyListeners();
  }

  Place getFavoriteById(int id) {
    return _favorites.firstWhere((element) => element.id == id);
  }
}
