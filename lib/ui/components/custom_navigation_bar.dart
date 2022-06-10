import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/ui/components/icon_box.dart';

/// TODO: implement BottomNavigationBarButton model with dynamic icon state.
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);

  final void Function(int)? onTap;
  final int currentIndex;

  static final List bottomButtons = [
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      backgroundColor: theme.backgroundColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      items: [
        for (var barItem in bottomButtons)
          BottomNavigationBarItem(
            activeIcon: IconBox(
              icon: barItem['icon']['name']['selected'],
              color: theme.textTheme.bodyText2!.color,
            ),
            icon: IconBox(
              icon: barItem['icon']['name']['unselected'],
              color: theme.textTheme.bodyText1!.color,
            ),
            label: barItem['label'],
          ),
      ],
    );
  }
}
