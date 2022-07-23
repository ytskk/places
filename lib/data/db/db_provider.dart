abstract class DBProvider {
  // getters
  Future<bool> isFirstOpen();
  Future<bool> isDarkMode();
  Future<String> getFilterOptions();

  // setters
  Future<void> setFirstOpen(bool isFirstOpen);
  Future<void> setDarkMode(bool isDarkMode);
  Future<void> setFilterOptions(String filterOptions);
}
