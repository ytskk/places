import 'package:flutter/widgets.dart';
import 'package:places/ui/navigation/app_route_names.dart';
import 'package:places/ui/navigation/screen_factory.dart';

class AppRoutes {
  static final _screenFactory = ScreenFactory();

  final Map<String, WidgetBuilder> routes = {
    AppRouteNames.onBoarding: (context) =>
        _screenFactory.makeOnboardingScreen(),
    AppRouteNames.home: (context) => _screenFactory.makeMainScreen(),
    AppRouteNames.favorites: (context) => _screenFactory.makeFavoritesScreen(),
    AppRouteNames.search: (context) => _screenFactory.makeSearchScreen(context),
    AppRouteNames.placeDetails: (context) =>
        _screenFactory.makePlaceDetailsScreen(),
    AppRouteNames.settings: (context) => _screenFactory.makeSettingsScreen(),
    AppRouteNames.addNewPlace: (context) =>
        _screenFactory.makeAddNewPlaceScreen(context),
  };
}
