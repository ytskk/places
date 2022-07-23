import 'dart:convert';
import 'dart:developer';

import 'package:places/data/blocs/filter/filter_cubit.dart';
import 'package:places/data/db/db_provider.dart';

class DBRepository {
  const DBRepository(
    this._dbProvider,
  );

  final DBProvider _dbProvider;

  // getters
  Future<bool> isFirstOpen() => _dbProvider.isFirstOpen();
  Future<bool> isDarkMode() => _dbProvider.isDarkMode();
  Future<FilterState> getFilterOptions() async {
    final String filterOptions = await _dbProvider.getFilterOptions();
    final Map<String, dynamic> json = jsonDecode(filterOptions);

    return FilterState.fromJson(json);
  }

  // setters
  Future<void> setFirstOpen(bool isFirstOpen) =>
      _dbProvider.setFirstOpen(isFirstOpen);
  Future<void> setDarkMode(bool isDarkMode) =>
      _dbProvider.setDarkMode(isDarkMode);
  Future<void> setFilterOptions(FilterState filterOptions) async {
    final String json = jsonEncode(filterOptions.toJson());

    _dbProvider.setFilterOptions(json);
  }
}
