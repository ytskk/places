import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/visiting_card.dart';
import 'package:places/ui/components/icon_box.dart';

class VisitingListElement extends StatelessWidget {
  final Sight sight;
  final List<Widget>? cardActions;
  final VoidCallback onDeleteButtonPressed;
  final bool isVisited;
  final String scheduledAt;
  final String workingStatus;

  const VisitingListElement({
    Key? key,
    required this.sight,
    this.cardActions,
    required this.onDeleteButtonPressed,
    this.isVisited = false,
    required this.scheduledAt,
    required this.workingStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Dismissible(
          key: ValueKey(sight),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection directions) {
            onDeleteButtonPressed();
          },
          background: const _DismissibleBackground(),
          child: VisitingCard(
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
          ),
        ),
      ),
    );
  }
}

class _DismissibleBackground extends StatelessWidget {
  const _DismissibleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyText2!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        );

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.red,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IconBox(
                icon: AppIcons.trash_bin,
                color: Colors.white,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                AppStrings.visitingDismissibleText,
                style: textTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
