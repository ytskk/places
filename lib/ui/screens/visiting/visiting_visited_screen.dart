import 'package:flutter/material.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/visiting/visiting_content.dart';
import 'package:places/ui/components/visiting/visiting_list_element.dart';
import 'package:provider/provider.dart';

class VisitingVisitedScreen extends StatelessWidget {
  const VisitingVisitedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Sight> li = context.watch<VisitingPlaces>().visitedPlaces;

    return VisitingContent(
      content: li,
      generator: (Sight sight) {
        return VisitingListElement(
          sight: sight,
          cardActions: [
            Button.icon(
              icon: AppIcons.share,
              background: Colors.transparent,
              onPressed: () {
                print('for $sight pressed share button');
              },
            ),
          ],
          isVisited: true,
          scheduledAt: 'Цель достигнута 12 окт. 2020',
          workingStatus: 'закрыто до 09:00',
          onDeleteButtonPressed: () {
            context.read<VisitingPlaces>().deleteVisitedPlaceById(sight.id);
          },
        );
      },
    );
  }
}
