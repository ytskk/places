import 'package:flutter/material.dart';

import '../../domain/app_colors.dart';
import '../../domain/app_strings.dart';
import 'tab_item.dart';

class SlidingTabBar extends StatelessWidget {
  final List<String> tabs;

  const SlidingTabBar(List<String> this.tabs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double defaultBorderRadius = 40;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: Theme.of(context).backgroundColor,
        ),
        child: TabBar(
          tabs: [
            for (String tabTitle in tabs) TabItem(text: tabTitle),
          ],
        ),
      ),
    );
  }
}
