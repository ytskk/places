import 'package:flutter/material.dart';
import 'package:places/controllers/add_sight_controller.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/controllers/navigation_controller.dart';
import 'package:places/controllers/settings_controller.dart';
import 'package:places/controllers/sight_search_controller.dart';
import 'package:places/controllers/onboarding_controller.dart';
import 'package:places/controllers/visiting_places_controller.dart';
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
        ChangeNotifierProvider(create: (_) => Settings()),
        ChangeNotifierProvider(create: (_) => Navigation()),
        ChangeNotifierProvider(create: (_) => Filter()),
        ChangeNotifierProvider(create: (_) => AddSight()),
        ChangeNotifierProvider(create: (_) => SightSearch()),
        ChangeNotifierProvider(create: (_) => VisitingPlaces()),
        ChangeNotifierProvider(create: (_) => Onboarding()),
      ],
      child: Consumer(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            theme: context.watch<Settings>().isDarkTheme
                ? AppThemeData.dark()
                : AppThemeData.dark(),
            home: MyHomePage(),
            // home: OnboardingScreen(),
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

/// TODO: implement BottomNavigationBarButton model with dynamic icon state.
class NavigationBar extends StatelessWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomButtons =
        context.read<Navigation>().bottomNavigationBarItemsData;

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
