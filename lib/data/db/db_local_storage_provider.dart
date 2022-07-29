import 'dart:developer';

import 'package:places/data/db/db_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBLocalStorageProvider implements DBProvider {
  DBLocalStorageProvider();

  @override
  Future<bool> isFirstOpen() async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.getBool('isFirstOpen') ?? true;
  }

  @override
  Future<void> setFirstOpen(bool isFirstOpen) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setBool('isFirstOpen', isFirstOpen);
  }

  @override
  Future<bool> isDarkMode() async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.getBool('isDarkMode') ?? false;
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Future<String> getFilterOptions() async {
    final _prefs = await SharedPreferences.getInstance();

    return _prefs.getString('filterOptions') ?? '';
  }

  @override
  Future<void> setFilterOptions(String filterOptions) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setString('filterOptions', filterOptions);
  }
}
