import 'package:places/data/model/place_model.dart';
import 'package:places/models/search_history_record.dart';
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
      isFavorite: true,
    ),
    Place(
      id: 12312321,
      lat: 2.13,
      lng: 13.123,
      name: "Second",
      urls: [""],
      type: SightCategories.hotel,
      description: "description",
      isFavorite: true,
    ),
  ];

  List<SearchHistoryRecord> _searchHistory = [
    SearchHistoryRecord(
      value: "query",
    ),
    SearchHistoryRecord(
      value: "query2",
    ),
  ];

  bool _isDarkMode = false;

  bool _isFirstOpen = true;

  // getters
  List<SearchHistoryRecord> get searchHistory => _searchHistory;

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

  void setFirstOpen(bool value) {
    _isFirstOpen = value;
  }

  // methods
  void addToSearchHistory(String query) {
    if (!_searchHistory.contains(
      // to avoid duplicates
      SearchHistoryRecord(value: query),
    )) {
      _searchHistory.add(
        SearchHistoryRecord(value: query),
      );
    }
  }

  void removeFromSearchHistory(SearchHistoryRecord historyRecord) async {
    _searchHistory = _searchHistory
        .where(
          (element) => element.id != historyRecord.id,
        )
        .toList();
  }

  void clearSearchHistory() {
    _searchHistory = [];
  }

  bool isFavorite(Place place) {
    return _favorites.indexWhere((element) => element.id == place.id) != -1;
  }

  void addFavorite(Place place) {
    _favorites.add(place);
  }

  void removeFavorite(Place place) {
    _favorites.removeWhere((element) => element.id == place.id);
  }

  Future<void> setPlannedAt(Place place, DateTime? plannedAt) async {
    place.plannedAt = plannedAt;
    _favorites = _favorites.map((element) {
      if (element.id == place.id) {
        return place;
      }

      return element;
    }).toList();
  }

  Place getFavoriteById(int id) {
    return _favorites.firstWhere((element) => element.id == id);
  }
}
