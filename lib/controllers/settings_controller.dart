import 'package:flutter/cupertino.dart';

class Settings extends ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  set setIsDarkTheme(bool newValue) {
    _isDarkTheme = newValue;
    notifyListeners();
  }
}
