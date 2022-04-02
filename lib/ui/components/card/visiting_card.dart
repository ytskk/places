import 'package:flutter/material.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/card/card.dart';

/// Model for sight card in visiting screen
class VisitingCard extends StatelessWidget {
  const VisitingCard(
    this.sight, {
    Key? key,
    this.actions = const [],
    this.scheduledAt = '',
    this.workingStatus = '',
    this.isVisited = false,
  }) : super(key: key);

  final Sight sight;
  final List<Widget> actions;
  final String scheduledAt;
  final String workingStatus;

  /// Controls [MyCard] subtitle color
  ///
  /// ```isVisited ? AppColors.textLabelSecondary : AppColors.green```
  final bool isVisited;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color scheduledAtColor =
        isVisited ? theme.textTheme.bodyText1!.color! : theme.cardColor;

    return MyCard(
      sight,
      actions: actions,
      cardInfo: CardInfo(
        title: sight.name,
        subtitle: scheduledAt,
        subtitleColor: scheduledAtColor,
        text: workingStatus,
      ),
    );
  }
}
