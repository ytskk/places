import 'package:flutter/widgets.dart';
import 'package:places/ui/navigation/main_navitation_route_names.dart';
import 'package:places/ui/navigation/screen_factory.dart';

class MainNavigation {
  static final _screenFactory = ScreenFactory();

  final routes = <String, WidgetBuilder>{
    MainNavigationRouteNames.onBoarding: (context) =>
        _screenFactory.makeOnboardingScreen(),
    MainNavigationRouteNames.home: (context) =>
        _screenFactory.makeSightScreen(),
    MainNavigationRouteNames.favorites: (context) =>
        _screenFactory.makeFavoritesScreen(),
    MainNavigationRouteNames.search: (context) =>
        _screenFactory.makeSearchScreen(context),
  };
}
