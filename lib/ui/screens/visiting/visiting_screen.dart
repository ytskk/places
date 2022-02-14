import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/tab_item.dart';
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
          // bottom: TabBar(
          //   tabs: [

          //   ],
          // ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: VisitingTabBar(),
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

class VisitingTabBar extends StatelessWidget {
  VisitingTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultBorderRadius = 40;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: AppColors.grayBackground,
        ),
        child: TabBar(
          unselectedLabelColor: AppColors.textLabelSecondary,
          labelColor: Colors.white,
          // indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            color: AppColors.textLabel,
          ),
          tabs: [
            for (int i = 0; i < AppStrings.visitingTabTitles.length; i += 1)
              Expanded(
                child: TabItem(
                  text: AppStrings.visitingTabTitles[i],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
