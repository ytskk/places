import 'package:places/data/db/app_db.dart';

class LocalRepository {
  final AppDb _appDb;

  LocalRepository(this._appDb);

  bool get isDarkMode => _appDb.isDarkMode;

  bool get isFirstOpen => _appDb.isFirstOpen;

  Future<void> setDarkMode(bool value) async => _appDb.setDarkMode(value);
}
