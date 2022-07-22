import 'package:places/data/db/app_db.dart';
import 'package:places/models/search_history_record.dart';

class LocalRepository {
  final AppDb _appDb;

  LocalRepository(this._appDb);

  // getters
  bool get isDarkMode => _appDb.isDarkMode;

  bool get isFirstOpen => _appDb.isFirstOpen;

  List<SearchHistoryRecord> get searchHistory => _appDb.searchHistory;

  // setters
  Future<void> setDarkMode(bool value) async => _appDb.setDarkMode(value);

  Future<void> setFirstOpen(bool value) async => _appDb.setFirstOpen(value);

  // methods
  void addToSearchHistory(String query) => _appDb.addToSearchHistory(query);

  Future<void> removeFromSearchHistory(SearchHistoryRecord record) async =>
      _appDb.removeFromSearchHistory(record);

  void clearSearchHistory() => _appDb.clearSearchHistory();
}
