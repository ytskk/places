import 'package:flutter/material.dart';

import 'tab_item.dart';

class SlidingTabBar extends StatelessWidget {
  final List<String> tabs;

  const SlidingTabBar(List<String> this.tabs, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    double defaultBorderRadius = 40;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          color: theme.backgroundColor,
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
