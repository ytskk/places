import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/components/card/card.dart';

/// Model for sight card in visiting screen
class VisitingCard extends StatelessWidget {
  /// [actions] - List of buttons.
  ///
  /// [scheduledAt] - Depends on [isVisited]
  ///
  /// [isVisited] – controls [MyCard] subtitle color
  ///
  /// ```isVisited ? AppColors.textLabelSecondary : AppColors.green```
  const VisitingCard(
    Sight this.sight, {
    Key? key,
    List<Widget> this.actions = const [],
    this.scheduledAt = '',
    this.workingStatus = '',
    this.isVisited = false,
  }) : super(key: key);

  final Sight sight;
  final List<Widget> actions;
  final String scheduledAt;
  final String workingStatus;
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
