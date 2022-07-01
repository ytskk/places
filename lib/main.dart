import 'package:flutter/material.dart';
import 'package:places/app.dart';

void main() {
  runApp(App());
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
