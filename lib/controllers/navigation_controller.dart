import 'package:flutter/cupertino.dart';
import 'package:places/domain/app_icons.dart';

class Navigation extends ChangeNotifier {
  final List _bottomNavigationBarItemsData = const [
    {
      'icon': {
        'name': {
          'selected': AppIcons.list_fill,
          'unselected': AppIcons.list,
        },
      },
      'label': 'Sight List',
    },
    {
      'icon': {
        'name': {
          'selected': AppIcons.map_fill,
          'unselected': AppIcons.map,
        },
      },
      'label': 'Map',
    },
    {
      'icon': {
        'name': {
          'selected': AppIcons.heartFilled,
          'unselected': AppIcons.heart,
        },
      },
      'label': 'Favorites',
    },
    {
      'icon': {
        'name': {
          'selected': AppIcons.settingsFilled,
          'unselected': AppIcons.settings,
        },
      },
      'label': 'Settings',
    },
  ];
  int _selectedPageIndex = 0;

  int get selectedPageIndex => _selectedPageIndex;

  List get bottomNavigationBarItemsData => _bottomNavigationBarItemsData;

  void setSelectedPageIndex(int newIndex) {
    _selectedPageIndex = newIndex;
    notifyListeners();
  }
}
