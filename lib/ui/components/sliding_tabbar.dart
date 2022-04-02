import 'package:flutter/material.dart';
import 'package:places/ui/components/tab_item.dart';

/// Custom designed [TabBar], uses [TabItem]
class SlidingTabBar extends StatelessWidget {
  /// Creates [TabItem] for provided [tabs]. tabs length must to match number of pages.
  const SlidingTabBar({
    Key? key,
    required this.tabs,
  }) : super(key: key);

  final List<String> tabs;

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
