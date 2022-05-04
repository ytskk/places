import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_routes.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/visiting_card.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/utils/string_manipulations.dart';

class VisitingListItem extends StatelessWidget {
  const VisitingListItem({
    Key? key,
    required this.place,
    this.cardActions,
    required this.onDeleteButtonPressed,
    this.isVisited = false,
    required this.scheduledAt,
    required this.workingStatus,
  }) : super(key: key);

  final Place place;
  final List<Widget>? cardActions;
  final VoidCallback onDeleteButtonPressed;
  final bool isVisited;
  final DateTime? scheduledAt;
  final String workingStatus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius:
            const BorderRadius.all(Radius.circular(smallBorderRadius)),
        child: Dismissible(
          key: ValueKey(place),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection directions) {
            onDeleteButtonPressed();
          },
          background: const _DismissibleBackground(),
          child: VisitingCard(
            place,
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.sightDetails,
                arguments: place.id,
              );
            },
            key: ValueKey(place),
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
            scheduledAt: scheduledAt != null
                ? '${AppStrings.visitingWantToVisitPlannedAt} ${formatDate(
                    scheduledAt!,
                    pattern: DateFormats.dayShortMonthYearDateFormat,
                  )}'
                : null,
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
        borderRadius:
            const BorderRadius.all(Radius.circular(smallBorderRadius)),
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
                height: smallSpacing,
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
