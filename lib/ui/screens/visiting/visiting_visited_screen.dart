import 'package:flutter/material.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/visiting_card.dart';
import 'package:places/ui/components/empty_list.dart';
import 'package:provider/provider.dart';

class VisitingVisitedScreen extends StatelessWidget {
  const VisitingVisitedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Sight> li = context.watch<VisitingPlaces>().visitedPlaces;

    return li.isNotEmpty
        ? SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: _VisitedList(sights: li),
          )
        : EmptyList(
            iconName: AppIcons.go,
            title: AppStrings.visitingEmpty,
            subtitle: AppStrings.visitingVisitedEmpty,
          );
  }
}

class _VisitedList extends StatelessWidget {
  final List<Sight> sights;

  const _VisitedList({
    Key? key,
    required this.sights,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (var sight in sights)
        VisitingCard(
          sight,
          key: sight.id,
          actions: [
            Button.icon(
              icon: AppIcons.share,
              iconColor: Colors.white,
              background: Colors.transparent,
              onPressed: () {
                print("Share icon clicked");
              },
            ),
            Button.icon(
              icon: AppIcons.close,
              iconColor: Colors.white,
              background: Colors.transparent,
              onPressed: () {
                context.read<VisitingPlaces>().deleteVisitedPlaceById(sight.id);
              },
            ),
          ],
          isVisited: true,
          scheduledAt: 'Цель достигнута 12 окт. 2020',
          workingStatus: 'закрыто до 09:00',
        ),
    ]);
  }
}
