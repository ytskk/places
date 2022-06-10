import 'package:flutter/material.dart';
import 'package:places/controllers/add_sight_controller.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/controllers/navigation_controller.dart';
import 'package:places/controllers/onboarding_controller.dart';
import 'package:places/controllers/sight_search_controller.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/data/api/client_api.dart';
import 'package:places/data/db/app_db.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/data/interactor/place_network_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/redux/app_state.dart';
import 'package:places/data/redux/reducer.dart';
import 'package:places/data/redux/search_middleware.dart';
import 'package:places/data/repository/local_repository.dart';
import 'package:places/data/repository/place_network_repository.dart';
import 'package:places/data/repository/place_storage_repository.dart';
import 'package:places/ui/navigation/app_route_names.dart';
import 'package:places/ui/navigation/app_routes.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ClientApi>(create: (_) => ClientApi()),
        ChangeNotifierProvider<AppDb>(create: (_) => AppDb()),
        ProxyProvider<ClientApi, PlaceNetworkRepository>(
          update: (_, clientApi, __) => PlaceNetworkRepository(clientApi),
        ),
        ProxyProvider<AppDb, PlaceStorageRepository>(
          update: (_, appDb, __) => PlaceStorageRepository(appDb),
        ),
        ProxyProvider2<PlaceNetworkRepository, PlaceStorageRepository,
            PlaceNetworkInteractor>(
          update: (_, placeNetworkRepository, placeStorageRepository, __) =>
              PlaceNetworkInteractor(
                  placeNetworkRepository, placeStorageRepository),
        ),
        ProxyProvider<PlaceStorageRepository, FavoritesInteractor>(
          update: (_, placeStorageRepository, favoritesInteractor) =>
              FavoritesInteractor(placeStorageRepository),
        ),
        ProxyProvider<AppDb, LocalRepository>(
          update: (_, appDb, __) => LocalRepository(appDb),
        ),
        ProxyProvider<LocalRepository, SettingsInteractor>(
          update: (_, localRepository, settingsInteractor) =>
              SettingsInteractor(localRepository),
        ),
        ProxyProvider<PlaceNetworkInteractor, Store<AppState>>(
          update: (_, placeNetworkInteractor, store) => Store<AppState>(
            reducer,
            initialState: AppState(),
            middleware: [
              SearchMiddleware(placeNetworkInteractor),
            ],
          ),
        ),
        ChangeNotifierProvider(create: (_) => Navigation()),
        ChangeNotifierProvider(create: (_) => Filter()),
        ChangeNotifierProvider(create: (_) => AddSight()),
        ChangeNotifierProvider(create: (_) => SightSearch()),
        ChangeNotifierProvider(create: (_) => VisitingPlaces()),
        ChangeNotifierProvider(create: (_) => Onboarding()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  final isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsInteractor>(
      builder: (BuildContext context, value, Widget? child) {
        final isDarkMode = value.isDarkMode();

        return MaterialApp(
          initialRoute: AppRouteNames.onBoarding,
          routes: AppRoutes().routes,
          theme: isDarkMode ? AppThemeData.dark() : AppThemeData.light(),
        );
      },
    );
  }
}
