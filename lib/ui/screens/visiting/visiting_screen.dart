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
              color: AppColors.whiteMain,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          //  Вопрос. Не очень придумал, как сделать изменение состояния таба
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(52),
            child: VisitingTabIndicator(),
          ),
        ),
        body: TabBarView(
          children: [
            //  Так же, при пустом списке сообщение выравнивается не по центру, как сделать
            // правильно, пока не придумал
            VisitingWantToVisitScreen(),
            VisitingVisitedScreen(),
          ],
        ),
      ),
    );
  }
}

class VisitingTabIndicator extends StatelessWidget {
  final int activeTabIndex;

  VisitingTabIndicator({Key? key, this.activeTabIndex = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppColors.grayBackground,
        ),
        child: Row(
          children: [
            for (int i = 0; i < AppStrings.visitingTabTitles.length; i += 1)
              Expanded(
                child: TabItem(
                  isActive: i == activeTabIndex,
                  text: AppStrings.visitingTabTitles[i],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
