import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/models/card_info.dart';
import 'package:places/ui/components/card/card.dart';

/// Model for sight card in visiting screen
class VisitingCard extends StatelessWidget {
  const VisitingCard(
    this.place, {
    Key? key,
    this.actions = const [],
    this.scheduledAt,
    this.workingStatus = '',
    this.isVisited = false,
    this.onTap,
  }) : super(key: key);

  final Place place;
  final List<Widget> actions;
  final String? scheduledAt;
  final String workingStatus;
  final VoidCallback? onTap;

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
      place,
      onTap: onTap,
      actions: actions,
      cardInfo: CardInfo(
        title: place.name,
        subtitle: scheduledAt,
        subtitleColor: scheduledAtColor,
        text: workingStatus,
      ),
    );
  }
}
