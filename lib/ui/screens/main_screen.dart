import 'package:flutter/material.dart';
import 'package:places/ui/components/custom_navigation_bar.dart';
import 'package:places/ui/navigation/screen_factory.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List _routes = [
    ScreenFactory().makeSightScreen(),
    ScreenFactory().makeSightScreen(),
    ScreenFactory().makeFavoritesScreen(),
    ScreenFactory().makeSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _routes[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
    );
  }
}
