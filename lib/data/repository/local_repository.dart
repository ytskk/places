import 'package:places/data/db/app_db.dart';

class LocalRepository {
  final AppDb _appDb;

  LocalRepository(this._appDb);

  Future<bool> get isDarkMode async => await _appDb.isDarkMode;

  Future<void> setDarkMode(bool value) async => _appDb.setDarkMode(value);
}
