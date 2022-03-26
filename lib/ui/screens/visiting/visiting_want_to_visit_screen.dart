import 'package:flutter/material.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/visiting_card.dart';
import 'package:provider/provider.dart';

class VisitingWantToVisitScreen extends StatelessWidget {
  const VisitingWantToVisitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Sight> li = context.watch<VisitingPlaces>().wantToVisitPlaces;

    return VisitingContent(content: li);
    // return li.isNotEmpty
    //     ? SingleChildScrollView(
    //         padding: EdgeInsets.all(16),
    //         child: _WantToVisitList(sights: li),
    //       )
    //     : EmptyList(
    //         iconName: AppIcons.card,
    //         title: AppStrings.visitingEmpty,
    //         subtitle: AppStrings.visitingWantToVisitEmpty,
    //       );
  }
}

class _WantToVisitList extends StatelessWidget {
  final List<Sight> sights;

  const _WantToVisitList({
    Key? key,
    required this.sights,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...sights.map((Sight sight) {
          return VisitingCard(
            sight,
            key: sight.id,
            actions: [
              Button.icon(
                icon: AppIcons.calendar,
                iconColor: Colors.white,
                background: Colors.transparent,
                onPressed: () {
                  print("Calendar icon clicked");
                },
              ),
              Button.icon(
                icon: AppIcons.close,
                iconColor: Colors.white,
                background: Colors.transparent,
                onPressed: () {
                  context
                      .read<VisitingPlaces>()
                      .deleteWantToVisitPlaceById(sight.id);
                },
              ),
            ],
            isVisited: false,
            scheduledAt: 'Запланировано на 12 окт. 2020',
            workingStatus: 'закрыто до 09:00',
          );
        }).toList(),
      ],
    );
  }
}
