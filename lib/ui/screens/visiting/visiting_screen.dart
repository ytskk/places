import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/screens/visiting/visiting_visited_screen.dart';
import 'package:places/ui/screens/visiting/visiting_want_to_visit_screen.dart';

import '../../components/sliding_tabbar.dart';

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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shadowColor: Colors.transparent,
          title: Text(
            AppStrings.visitingAppBarTitle,
            style: TextStyle(
              color: AppColors.textLabel,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: const SlidingTabBar(AppStrings.visitingTabTitles),
          ),
        ),
        body: TabBarView(
          children: [
            VisitingWantToVisitScreen(),
            VisitingVisitedScreen(),
          ],
        ),
      ),
    );
  }
}
