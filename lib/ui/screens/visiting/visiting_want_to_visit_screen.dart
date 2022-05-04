import 'package:flutter/material.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/picker.dart';
import 'package:places/ui/components/visiting/visiting_list_item.dart';
import 'package:provider/provider.dart';

class VisitingWantToVisitScreen extends StatefulWidget {
  const VisitingWantToVisitScreen({Key? key}) : super(key: key);

  @override
  State<VisitingWantToVisitScreen> createState() =>
      _VisitingWantToVisitScreenState();
}

class _VisitingWantToVisitScreenState extends State<VisitingWantToVisitScreen> {
  late final Future future;

  @override
  void initState() {
    super.initState();

    // future = getFavorites(context);
  }

  Future getFavorites(BuildContext context) async {
    return context.watch<FavoritesInteractor>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText2!.color;

    return FutureBuilder(
      future: context.watch<FavoritesInteractor>().getFavorites(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        final List<Place> favoritesPlaces = snapshot.data ?? [];

        if (favoritesPlaces.isEmpty) {
          return Center(
            child: InfoList(
              iconName: AppIcons.card,
              iconColor: textColor,
              title: Text(AppStrings.visitingEmpty),
              subtitle: Text(
                AppStrings.visitingWantToVisitEmpty,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return ReorderableListView(
          padding: const EdgeInsets.all(16),
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final Place item = favoritesPlaces.removeAt(oldIndex);
              favoritesPlaces.insert(newIndex, item);
            });
          },
          children: [
            ...favoritesPlaces.map(
              (place) => VisitingListItem(
                key: ValueKey(place),
                place: place,
                cardActions: [
                  Button.icon(
                    icon: AppIcons.calendar,
                    iconColor: Colors.white,
                    background: Colors.transparent,
                    onPressed: () async {
                      DateTime? remindDate = await Picker.Adaptive(
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ).show(context);

                      context
                          .read<FavoritesInteractor>()
                          .setPlannedAt(place, remindDate);

                      print(
                          '$place is planned to visit on ${remindDate?.toLocal()}');
                    },
                  ),
                ],
                isVisited: true,
                scheduledAt: place.plannedAt,
                workingStatus: '${AppStrings.visitingVisitedClosedUntil} 09:00',
                onDeleteButtonPressed: () {
                  context.read<FavoritesInteractor>().removeFavorite(place);
                },
              ),
            ),
          ],
        );
      },
    );

    // return favoritesPlaces.isNotEmpty
    //     ? ReorderableListView(
    //         padding: const EdgeInsets.all(16),
    //         onReorder: (int oldIndex, int newIndex) {
    //           setState(() {
    //             if (oldIndex < newIndex) {
    //               newIndex -= 1;
    //             }
    //             // final Place item = wantToVisitPlaces.removeAt(oldIndex);
    //             // wantToVisitPlaces.insert(newIndex, item);
    //           });
    //         },
    //         children: [
    //           ...favoritesPlaces.map(
    //             (place) => VisitingListItem(
    //               key: ValueKey(place),
    //               place: place,
    //               cardActions: [
    //                 Button.icon(
    //                   icon: AppIcons.calendar,
    //                   iconColor: Colors.white,
    //                   background: Colors.transparent,
    //                   onPressed: () async {
    //                     DateTime? remindDate = await Picker.Adaptive(
    //                       initialDate: DateTime.now(),
    //                       firstDate: DateTime.now(),
    //                       lastDate:
    //                           DateTime.now().add(const Duration(days: 365)),
    //                     ).show(context);

    //                     print(
    //                         '$place is planned to visit on ${remindDate?.toLocal()}');
    //                   },
    //                 ),
    //               ],
    //               isVisited: true,
    //               scheduledAt:
    //                   '${AppStrings.visitingWantToVisitPlannedAt} 12 окт. 2020',
    //               workingStatus:
    //                   '${AppStrings.visitingVisitedClosedUntil} 09:00',
    //               onDeleteButtonPressed: () {
    //                 // context.read<VisitingPlaces>().removeFromFavorites(place);
    //               },
    //             ),
    //           ),
    //         ],
    //       )
    //     : Center(
    //         child: InfoList(
    //           iconName: AppIcons.card,
    //           iconColor: textColor,
    //           title: Text(AppStrings.visitingEmpty),
    //           subtitle: Text(
    //             AppStrings.visitingWantToVisitEmpty,
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //       );
  }
}
