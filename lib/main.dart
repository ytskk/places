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
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/interactor/settings_interactor.dart';
import 'package:places/data/repository/local_repository.dart';
import 'package:places/data/repository/place_network_repository.dart';
import 'package:places/data/repository/place_storage_repository.dart';
import 'package:places/domain/app_routes.dart';
import 'package:places/ui/components/custom_navigation_bar.dart';
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
        Provider<ClientApi>(create: (_) => ClientApi()),
        ChangeNotifierProvider<AppDb>(create: (_) => AppDb()),
        ProxyProvider<ClientApi, PlaceNetworkRepository>(
          update: (_, clientApi, __) => PlaceNetworkRepository(clientApi),
        ),
        ProxyProvider<AppDb, PlaceStorageRepository>(
          update: (_, appDb, __) => PlaceStorageRepository(appDb),
        ),
        ProxyProvider2<PlaceNetworkRepository, PlaceStorageRepository,
            PlaceInteractor>(
          update: (_, placeNetworkRepository, placeStorageRepository, __) =>
              PlaceInteractor(placeNetworkRepository, placeStorageRepository),
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
        ChangeNotifierProvider(create: (_) => Navigation()),
        ChangeNotifierProvider(create: (_) => Filter()),
        ChangeNotifierProvider(create: (_) => AddSight()),
        ChangeNotifierProvider(create: (_) => SightSearch()),
        ChangeNotifierProvider(create: (_) => VisitingPlaces()),
        ChangeNotifierProvider(create: (_) => Onboarding()),
      ],
      child: Consumer(
        builder: (BuildContext context, value, Widget? child) {
          return FutureBuilder(
            future: context.watch<SettingsInteractor>().isDarkMode(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              final theme = snapshot.data ?? false;

              return MaterialApp(
                routes: routes,
                initialRoute: AppRoutes.onboarding,
                // theme: AppThemeData.light(),
                theme: theme ? AppThemeData.dark() : AppThemeData.light(),
                // theme: context.watch<SettingsInteractor>().isDarkMode
                //     ? AppThemeData.dark()
                //     : AppThemeData.light(),
                // home: MyHomePage(),
                // home: const SplashScreen(),
                // home: OnboardingScreen(),
              );
            },
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
    SightScreen(),
    SightDetailsScreen(),
    VisitingScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[context.watch<Navigation>().selectedPageIndex % pages.length],
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}
