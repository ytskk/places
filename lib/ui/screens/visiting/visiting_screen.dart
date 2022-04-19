import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/sliding_tabbar.dart';
import 'package:places/ui/screens/visiting/visiting_visited_screen.dart';
import 'package:places/ui/screens/visiting/visiting_want_to_visit_screen.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppStrings.visitingTabTitles.length,
      child: const Scaffold(
        appBar: const CustomAppBar(
          title: Text(
            AppStrings.visitingAppBarTitle,
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(bottomAppBarHeight),
            child: SlidingTabBar(tabs: AppStrings.visitingTabTitles),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              // TODO: merge base;
              VisitingWantToVisitScreen(),
              VisitingVisitedScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
