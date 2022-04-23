import 'package:flutter/material.dart';
import 'package:places/controllers/add_sight_controller.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/controllers/navigation_controller.dart';
import 'package:places/controllers/onboarding_controller.dart';
import 'package:places/controllers/settings_controller.dart';
import 'package:places/controllers/sight_search_controller.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/dio_test.dart';
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
        ChangeNotifierProvider(create: (_) => Settings()),
        ChangeNotifierProvider(create: (_) => Navigation()),
        ChangeNotifierProvider(create: (_) => Filter()),
        ChangeNotifierProvider(create: (_) => AddSight()),
        ChangeNotifierProvider(create: (_) => SightSearch()),
        ChangeNotifierProvider(create: (_) => VisitingPlaces()),
        ChangeNotifierProvider(create: (_) => Onboarding()),
      ],
      child: Consumer(
        builder: (BuildContext context, value, Widget? child) {
          return MaterialApp(
            // routes: routes,
            // initialRoute: AppRoutes.onboarding,
            home: DioTestScreen(),
            theme: context.watch<Settings>().isDarkTheme
                ? AppThemeData.dark()
                : AppThemeData.light(),
            // home: MyHomePage(),
            // home: const SplashScreen(),
            // home: OnboardingScreen(),
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
