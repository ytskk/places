import 'package:flutter/material.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/empty_list.dart';
import 'package:places/ui/components/visiting/visiting_list_item.dart';
import 'package:provider/provider.dart';

class VisitingVisitedScreen extends StatefulWidget {
  const VisitingVisitedScreen({Key? key}) : super(key: key);

  @override
  State<VisitingVisitedScreen> createState() => _VisitingVisitedScreenState();
}

class _VisitingVisitedScreenState extends State<VisitingVisitedScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Sight> li = context.watch<VisitingPlaces>().visitedPlaces;

    // return VisitingListContent<Sight>(
    //   liContent: li,
    //   liContentChildren: [
    //     ...li.map(
    //       (sight) => VisitingListItem(
    //         key: ValueKey(sight),
    //         sight: sight,
    //         cardActions: [
    //           Button.icon(
    //             icon: AppIcons.share,
    //             iconColor: Colors.white,
    //             background: Colors.transparent,
    //             onPressed: () {
    //               print('for $sight pressed share button');
    //             },
    //           ),
    //         ],
    //         scheduledAt: '${AppStrings.visitingVisitedAchieved} 12 окт. 2020',
    //         workingStatus: '${AppStrings.visitingVisitedClosedUntil} 09:00',
    //         onDeleteButtonPressed: () {
    //           //                 context
    //           //                     .read<VisitingPlaces>()
    //           //                     .deleteVisitedPlaceById(sight.id);
    //
    //           context
    //               .read<VisitingPlaces>()
    //               .deleteWantToVisitPlaceById(sight.id);
    //         },
    //       ),
    //     ),
    //   ],
    //   emptyListTitle: AppStrings.visitingEmpty,
    //   emptyListSubtitle: AppStrings.visitingWantToVisitEmpty,
    //   emptyListIconName: AppIcons.card,
    // );

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
                      '${AppStrings.visitingVisitedAchieved} 12 окт. 2020',
                  workingStatus:
                      '${AppStrings.visitingVisitedClosedUntil} 09:00',
                  onDeleteButtonPressed: () {
                    context
                        .read<VisitingPlaces>()
                        .deleteVisitedPlaceById(sight.id);
                  },
                ),
              ),
            ],
          )
        : InfoList(
            iconName: AppIcons.go,
            title: Text(AppStrings.visitingEmpty),
            subtitle: Text(AppStrings.visitingVisitedEmpty),
          );
  }
}
