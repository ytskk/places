import 'package:flutter/material.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/visiting/visiting_content.dart';
import 'package:places/ui/components/visiting/visiting_list_element.dart';
import 'package:provider/provider.dart';

class VisitingWantToVisitScreen extends StatelessWidget {
  const VisitingWantToVisitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Sight> li = context.watch<VisitingPlaces>().wantToVisitPlaces;

    return VisitingContent(
      content: li,
      generator: (Sight sight) {
        return VisitingListElement(
          sight: sight,
          cardActions: [
            Button.icon(
              icon: AppIcons.calendar,
              iconColor: Colors.white,
              background: Colors.transparent,
              onPressed: () {
                print('for $sight pressed calendar button');
              },
            ),
          ],
          scheduledAt: 'Запланировано на 12 окт. 2020',
          workingStatus: 'закрыто до 09:00',
          onDeleteButtonPressed: () {
            context.read<VisitingPlaces>().deleteWantToVisitPlaceById(sight.id);
          },
        );
      },
    );
  }
}
