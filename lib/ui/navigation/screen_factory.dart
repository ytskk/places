import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/repository/local_repository.dart';
import 'package:places/ui/screens/add_sight/bloc/add_sight_bloc.dart';
import 'package:places/ui/screens/add_sight/view/add_sight_screen.dart';
import 'package:places/ui/screens/filter/bloc/filtering_places_bloc.dart';
import 'package:places/ui/screens/filter/filter_screen.dart';
import 'package:places/ui/screens/main_screen.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/settings/settings_screen.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/screens/sight_screen.dart';
import 'package:places/ui/screens/sight_search/bloc/search_bloc.dart';
import 'package:places/ui/screens/sight_search/view/sight_search_screen.dart';
import 'package:places/ui/screens/splash_screen.dart';
import 'package:places/ui/screens/visiting/favorites_screen.dart';

class ScreenFactory {
  Widget makeSplashScreen() {
    return const SplashScreen();
  }

  Widget makeMainScreen() {
    return MainScreen();
  }

  Widget makeSightScreen() {
    return SightScreen();
  }

  Widget makeOnboardingScreen() {
    return OnboardingScreen();
  }

  Widget makeFavoritesScreen() {
    return FavoritesScreen();
  }

  Widget makeFilterScreen(BuildContext context) {
    final placeInteractor = context.read<PlaceInteractor>();

    return BlocProvider(
      create: (context) => FilteringPlacesBloc(placeInteractor),
      child: FilterScreen(),
    );
  }

  Widget makeSearchScreen(BuildContext context) {
    final placeInteractor = context.read<PlaceInteractor>();
    final localRepository = context.read<LocalRepository>();

    return BlocProvider(
      create: (context) => SearchBloc(
        placeInteractor,
        localRepository,
      )..add(SearchHistoryLoad()),
      child: SightSearchScreen(),
    );
  }

  Widget makePlaceDetailsScreen() {
    return SightDetailsScreen();
  }

  Widget makeSettingsScreen() {
    return SettingsScreen();
  }

  Widget makeAddNewPlaceScreen(BuildContext context) {
    final placeInteractor = context.read<PlaceInteractor>();

    return BlocProvider(
      create: (context) => AddSightBloc(placeInteractor),
      child: AddSightScreen(),
    );
  }
}
