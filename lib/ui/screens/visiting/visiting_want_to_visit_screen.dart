import 'package:flutter/material.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/visiting/visiting_list_item.dart';
import 'package:provider/provider.dart';

class VisitingWantToVisitScreen extends StatefulWidget {
  const VisitingWantToVisitScreen({Key? key}) : super(key: key);

  @override
  State<VisitingWantToVisitScreen> createState() =>
      _VisitingWantToVisitScreenState();
}

class _VisitingWantToVisitScreenState extends State<VisitingWantToVisitScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Sight> li = context.watch<VisitingPlaces>().wantToVisitPlaces;

    return li.isNotEmpty
        ? ReorderableListView(
            padding: const EdgeInsets.all(16),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Sight item = li.removeAt(oldIndex);
                li.insert(newIndex, item);
              });
            },
            children: [
              ...li.map(
                (sight) => VisitingListItem(
                  key: ValueKey(sight),
                  sight: sight,
                  cardActions: [
                    Button.icon(
                      icon: AppIcons.share,
                      iconColor: Colors.white,
                      background: Colors.transparent,
                      onPressed: () {
                        print('for $sight pressed share button');
                      },
                    ),
                  ],
                  isVisited: true,
                  scheduledAt:
                      '${AppStrings.visitingWantToVisitPlannedAt} 12 окт. 2020',
                  workingStatus:
                      '${AppStrings.visitingVisitedClosedUntil} 09:00',
                  onDeleteButtonPressed: () {
                    context
                        .read<VisitingPlaces>()
                        .deleteWantToVisitPlaceById(sight.id);
                  },
                ),
              ),
            ],
          )
        : InfoList(
            iconName: AppIcons.card,
            title: Text(AppStrings.visitingEmpty),
            subtitle: Text(AppStrings.visitingWantToVisitEmpty),
          );
    // return VisitingListContent<Sight>(
    //   liContent: context.watch<VisitingPlaces>().wantToVisitPlaces,
    //   liContentChildren: [
    //     ...context.watch<VisitingPlaces>().wantToVisitPlaces.map(
    //           (sight) => VisitingListItem(
    //             key: ValueKey(sight),
    //             sight: sight,
    //             cardActions: [
    //               Button.icon(
    //                 icon: AppIcons.calendar,
    //                 iconColor: Colors.white,
    //                 background: Colors.transparent,
    //                 onPressed: () {
    //                   print('for $sight pressed calendar button');
    //                 },
    //               ),
    //             ],
    //             scheduledAt:
    //                 '${AppStrings.visitingWantToVisitPlannedAt} 12 окт. 2020',
    //             workingStatus:
    //                 '${AppStrings.visitingWantToVisitClosedUntil} 09:00',
    //             onDeleteButtonPressed: () {
    //               context
    //                   .read<VisitingPlaces>()
    //                   .deleteWantToVisitPlaceById(sight.id);
    //             },
    //           ),
    //         ),
    //   ],
    //   emptyListTitle: AppStrings.visitingEmpty,
    //   emptyListSubtitle: AppStrings.visitingWantToVisitEmpty,
    //   emptyListIconName: AppIcons.card,
    // );
  }
}
