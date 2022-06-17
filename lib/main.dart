import 'package:flutter/material.dart';
import 'package:places/app.dart';
import 'package:places/data/api/client_api.dart';
import 'package:places/data/db/app_db.dart';
import 'package:places/data/interactor/place_network_interactor.dart';
import 'package:places/data/redux/middleware/search_middleware.dart';
import 'package:places/data/redux/reducers/reducer.dart';
import 'package:places/data/redux/states/app_state.dart';
import 'package:places/data/repository/place_network_repository.dart';
import 'package:places/data/repository/place_storage_repository.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(
    reducer,
    initialState: AppState(),
    middleware: [
      SearchMiddleware(PlaceNetworkInteractor(
        PlaceNetworkRepository(ClientApi()),
        PlaceStorageRepository(AppDb()),
      )),
    ],
  );

  runApp(App(store: store));
}

// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<Widget> pages = [
//     SightScreen(),
//     SightDetailsScreen(),
//     // VisitingScreen(),
//     // ScreenFactory().makeFavoritesScreen(),
//     SettingsScreen(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[context.watch<Navigation>().selectedPageIndex % pages.length],
//       bottomNavigationBar: CustomNavigationBar(),
//     );
//   }
// }
