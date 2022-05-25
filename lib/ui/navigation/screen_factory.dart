import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocks/favorites/favorites_bloc.dart';
import 'package:places/data/blocks/favorites/favorites_event.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/ui/screens/onboarding_screen.dart';
import 'package:places/ui/screens/sight_screen.dart';
import 'package:places/ui/screens/visiting/favorites_screen.dart';

class ScreenFactory {
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
}
