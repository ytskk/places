import 'package:places/data/repository/local_repository.dart';

class SettingsInteractor {
  SettingsInteractor(this._localRepository);

  final LocalRepository _localRepository;

  Future<bool> isDarkMode() async {
    return await _localRepository.isDarkMode;
  }

  Future<void> setDarkMode(bool value) async {
    await _localRepository.setDarkMode(value);
  }
}
