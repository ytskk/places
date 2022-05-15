import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/sliding_tabbar.dart';

class VisitingScreen extends StatefulWidget {
  const VisitingScreen({Key? key}) : super(key: key);

  @override
  _VisitingScreenState createState() => _VisitingScreenState();
}

class _VisitingScreenState extends State<VisitingScreen> {
  final favoriteFactories = [
    Center(child: Text(AppStrings.visitingAppBarTitle)),
    Center(child: Text(AppStrings.visitingAppBarTitle)),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AppStrings.visitingTabTitles.length,
      child: Scaffold(
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
            children: favoriteFactories,
            // children: [
            //   // TODO: merge base;
            //   VisitingWantToVisitScreen(),
            //   VisitingVisitedScreen(),
            // ],
          ),
        ),
      ),
    );
  }
}
