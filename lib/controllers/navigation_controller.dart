import 'package:flutter/cupertino.dart';

class Navigation extends ChangeNotifier {
  int _selectedPageIndex = 0;

  int get selectedPageIndex => _selectedPageIndex;

  void setSelectedPageIndex(int newIndex) {
    _selectedPageIndex = newIndex;
    notifyListeners();
  }
}
