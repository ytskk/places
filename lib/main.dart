import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/mocks.dart';
import 'package:places/themes.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/ui/screens/sight_screen.dart';
import 'package:places/ui/screens/visiting/visiting_screen.dart';

import 'ui/screens/sight_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = [
    SightListScreen(),
    SightDetails(mocks[3]),
    VisitingScreen(),
  ];
  int activePageIndex = 0;

  List bottomNavigationBarItemsData = [
    {
      'icon': {
        'name': {
          'selected': AppIcons.list_fill,
          'unselected': AppIcons.list,
        },
        'color': {
          'selected': AppColors.textLabel,
          'unselected': AppColors.textLabel,
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
        'color': {
          'selected': AppColors.textLabel,
          'unselected': AppColors.textLabel,
        },
      },
      'label': 'Map',
    },
    {
      'icon': {
        'name': {
          'selected': AppIcons.heart_fill,
          'unselected': AppIcons.heart,
        },
        'color': {
          'selected': AppColors.textLabel,
          'unselected': AppColors.textLabel,
        },
      },
      'label': 'Favorites',
    },
    {
      'icon': {
        'name': {
          'selected': AppIcons.settings_fill,
          'unselected': AppIcons.settings,
        },
        'color': {
          'selected': AppColors.textLabel,
          'unselected': AppColors.textLabel,
        },
      },
      'label': 'Settings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[activePageIndex % pages.length],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: activePageIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            activePageIndex = value;
          });
        },
        items: [
          for (var barItem in bottomNavigationBarItemsData)
            BottomNavigationBarItem(
              activeIcon: IconBox(
                icon: barItem['icon']['name']['selected'],
                color: barItem['icon']['color']['selected'],
              ),
              icon: IconBox(
                icon: barItem['icon']['name']['unselected'],
                color: barItem['icon']['color']['unselected'],
              ),
              label: barItem['label'],
            ),
        ],
      ),
    );
  }
}
