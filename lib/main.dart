import 'package:flutter/material.dart';
import 'package:places/controllers/add_sight_controller.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/controllers/navigation_controller.dart';
import 'package:places/controllers/settings_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:places/ui/screens/settings/settings_screen.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/screens/sight_screen.dart';
import 'package:places/ui/screens/visiting/visiting_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (_) => Settings()),
        ListenableProvider(create: (_) => Navigation()),
        ChangeNotifierProvider(create: (_) => Filter()),
        ChangeNotifierProvider(create: (_) => AddSight()),
      ],
      child: Consumer(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            theme: context.watch<Settings>().isDarkTheme
                ? AppThemeData.dark()
                : AppThemeData.light(),
            // home: FilterScreen(),
            // home: AddSightScreen(),
            home: MyHomePage(),
          );
        },
      ),
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
    SightDetails(mocks[mocks.length - 1]),
    VisitingScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[context.watch<Navigation>().selectedPageIndex % pages.length],
      bottomNavigationBar: NavigationBar(),
    );
  }
}

class NavigationBar extends StatelessWidget {
  static const List _bottomNavigationBarItemsData = const [
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
          'selected': AppIcons.heart_fill,
          'unselected': AppIcons.heart,
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
      },
      'label': 'Settings',
    },
  ];

  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      backgroundColor: theme.backgroundColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: context.watch<Navigation>().selectedPageIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int value) {
        context.read<Navigation>().setSelectedPageIndex(value);
      },
      items: [
        for (var barItem in _bottomNavigationBarItemsData)
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
