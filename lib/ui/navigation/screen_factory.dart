import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/ui/screens/add_sight/bloc/add_sight_bloc.dart';
import 'package:places/ui/screens/add_sight/view/add_sight_screen.dart';
import 'package:places/ui/screens/filter/filter_screen.dart';
import 'package:places/ui/screens/main_screen.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/settings/settings_screen.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/screens/sight_screen.dart';
import 'package:places/ui/screens/sight_search/sight_search_screen.dart';
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
    return BlocProvider<FavoritesBloc>(
      create: (BuildContext context) {
        return FavoritesBloc(context.read<FavoritesInteractor>())
          ..add(FavoritesLoad());
      },
      child: FavoritesScreen(),
    );
  }

  Widget makeFilterScreen() {
    return FilterScreen();
  }

  Widget makeSearchScreen(BuildContext context) {
    // final store = context.read<Store<AppState>>();

    // return StoreProvider(
    //   store: store,
    //   child: SightSearchScreen(),
    // );
    return SightSearchScreen();
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
