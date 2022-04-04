import 'package:flutter/cupertino.dart';

class Settings extends ChangeNotifier {
  // definitions.

  bool _isDarkTheme = false;

  // getters.

  bool get isDarkTheme => _isDarkTheme;

  // setters.

  set setIsDarkTheme(bool newValue) {
    _isDarkTheme = newValue;
    notifyListeners();
  }
}
