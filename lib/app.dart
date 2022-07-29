import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/api/client_api.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/data/blocs/favorites/favorites_cubit.dart';
import 'package:places/data/db/app_db.dart';
import 'package:places/data/db/db_local_storage_provider.dart';
import 'package:places/data/db/db_provider.dart';
import 'package:places/data/db/db_repository.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/place_network_interactor.dart';
import 'package:places/data/repository/local_repository.dart';
import 'package:places/data/repository/place_network_repository.dart';
import 'package:places/data/repository/place_storage_repository.dart';
import 'package:places/ui/navigation/app_route_names.dart';
import 'package:places/ui/navigation/app_routes.dart';
import 'package:places/ui/screens/main_screen/cubit/main_navigation_cubit.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ClientApi>(create: (_) => ClientApi()),
        Provider<AppDb>(create: (_) => AppDb()),
        Provider<DBProvider>(create: (_) => DBLocalStorageProvider()),
        ProxyProvider<DBProvider, DBRepository>(
          update: (_, dbProvider, __) => DBRepository(dbProvider),
        ),
        ProxyProvider<AppDb, PlaceStorageRepository>(
          update: (_, appDb, __) => PlaceStorageRepository(appDb),
        ),
        ProxyProvider<ClientApi, PlaceNetworkRepository>(
          update: (_, clientApi, __) => PlaceNetworkRepository(clientApi),
        ),
        ProxyProvider<AppDb, LocalRepository>(
          update: (_, appDb, __) => LocalRepository(appDb),
        ),
        ProxyProvider2<PlaceNetworkRepository, PlaceStorageRepository,
            PlaceInteractor>(
          update: (_, placeNetworkRepository, placeStorageRepository, __) =>
              PlaceNetworkInteractor(
                  placeNetworkRepository, placeStorageRepository),
        ),
        ProxyProvider<PlaceStorageRepository, FavoritesInteractor>(
          update: (_, placeStorageRepository, __) =>
              FavoritesInteractor(placeStorageRepository),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              return MainNavigationCubit();
            },
          ),
          BlocProvider<PreferencesCubit>(
            create: (BuildContext context) {
              return PreferencesCubit(context.read<DBRepository>())
                ..loadPreferences();
            },
          ),
          BlocProvider<PlacesBloc>(
            create: (BuildContext context) {
              return PlacesBloc(
                placesInteractor: context.read<PlaceInteractor>(),
              )..add(PlacesLoadInitial());
            },
          ),
          BlocProvider<PlaceDetailsCubit>(
            create: (BuildContext context) {
              return PlaceDetailsCubit(
                placeInteractor: context.read<PlaceInteractor>(),
              );
            },
          ),
          BlocProvider(
            create: (BuildContext context) {
              return FilterCubit();
            },
          ),
          BlocProvider(
            create: (BuildContext context) {
              return FavoritesCubit(context.read<FavoritesInteractor>());
            },
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesCubit, PreferencesState>(
      builder: (BuildContext context, state) {
        return MaterialApp(
          initialRoute: AppRouteNames.splash,
          routes: AppRoutes.routes,
          theme: state.isDarkMode ? AppThemeData.dark() : AppThemeData.light(),
        );
      },
    );
  }
}
