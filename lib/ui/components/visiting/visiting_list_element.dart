import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/visiting_card.dart';

class VisitingListElement extends StatelessWidget {
  final Sight sight;
  final List<Widget>? cardActions;
  final VoidCallback? onDeleteButtonPressed;
  final bool isVisited;
  final String scheduledAt;
  final String workingStatus;

  const VisitingListElement({
    Key? key,
    required this.sight,
    this.cardActions,
    this.onDeleteButtonPressed,
    this.isVisited = false,
    required this.scheduledAt,
    required this.workingStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VisitingCard(
      sight,
      key: ValueKey(sight),
      actions: [
        ...?cardActions,
        Button.icon(
          icon: AppIcons.close,
          iconColor: Colors.white,
          background: Colors.transparent,
          onPressed: onDeleteButtonPressed,
        ),
      ],
      isVisited: isVisited,
      scheduledAt: scheduledAt,
      workingStatus: workingStatus,
    );
  }
}
