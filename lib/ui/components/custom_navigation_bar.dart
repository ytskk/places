import 'package:flutter/material.dart';
import 'package:places/controllers/navigation_controller.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:provider/provider.dart';

/// TODO: implement BottomNavigationBarButton model with dynamic icon state.
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomButtons =
        context.read<Navigation>().bottomNavigationBarItemsData;

    return BottomNavigationBar(
      backgroundColor: theme.backgroundColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: context.watch<Navigation>().selectedPageIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int value) {
        context.read<Navigation>().setSelectedPageIndex(value);
      },
      items: [
        for (var barItem in bottomButtons)
          BottomNavigationBarItem(
            activeIcon: IconBox(
              icon: barItem['icon']['name']['selected'],
              color: theme.textTheme.bodyText2!.color,
            ),
            icon: IconBox(
              icon: barItem['icon']['name']['unselected'],
              color: theme.textTheme.bodyText1!.color,
            ),
            label: barItem['label'],
          ),
      ],
    );
  }
}
