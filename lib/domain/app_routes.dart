import 'package:flutter/cupertino.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/add_sight/add_sight_screen.dart';
import 'package:places/ui/screens/filter/filter_screen.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/settings/settings_screen.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/screens/sight_search/sight_search_screen.dart';
import 'package:places/ui/screens/splash_screen.dart';

// TODO: optimize routing. Merge all routes into one class.

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.splash: (context) => SplashScreen(),
  AppRoutes.onboarding: (context) => OnboardingScreen(),
  AppRoutes.home: (BuildContext context) => MyHomePage(),
  AppRoutes.settings: (BuildContext context) => SettingsScreen(),
  AppRoutes.sightDetails: (BuildContext context) => SightDetailsScreen(),
  AppRoutes.search: (BuildContext context) => SightSearchScreen(),
  AppRoutes.sightFilter: (BuildContext context) => FilterScreen(),
  AppRoutes.addSight: (BuildContext context) => AddSightScreen(),
};

class AppRoutes {
  static const String splash = '/splash-screen';
  static const String onboarding = '/onboarding';
  static const String home = '/';
  static const String settings = '/settings';
  static const String sightDetails = '/sight-details';
  static const String search = '/search';
  static const String sightFilter = '/sight-filter';
  static const String addSight = '/add-sight';
}
