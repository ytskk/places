import 'package:flutter/material.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/visiting/visiting_list_item.dart';
import 'package:provider/provider.dart';

class VisitingVisitedScreen extends StatefulWidget {
  const VisitingVisitedScreen({Key? key}) : super(key: key);

  @override
  State<VisitingVisitedScreen> createState() => _VisitingVisitedScreenState();
}

class _VisitingVisitedScreenState extends State<VisitingVisitedScreen> {
  final List<Place> visitedPlaces = [];

  @override
  initState() {
    super.initState();

    // context.read<VisitingPlaces>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText2!.color;

    // final List<Sight> visitedPlaces = [];
    // context.watch<VisitingPlaces>().visitedPlaces;

    return visitedPlaces.isNotEmpty
        ? ReorderableListView(
            padding: const EdgeInsets.all(16),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Place item = visitedPlaces.removeAt(oldIndex);
                visitedPlaces.insert(newIndex, item);
              });
            },
            children: [
              ...visitedPlaces.map(
                (place) => VisitingListItem(
                  key: ValueKey(place),
                  place: place,
                  cardActions: [
                    Button.icon(
                      icon: AppIcons.share,
                      iconColor: Colors.white,
                      background: Colors.transparent,
                      onPressed: () {
                        print('for $place pressed share button');
                      },
                    ),
                  ],
                  isVisited: true,
                  scheduledAt: place.plannedAt,
                  workingStatus:
                      '${AppStrings.visitingVisitedClosedUntil} 09:00',
                  onDeleteButtonPressed: () {
                    context.read<FavoritesInteractor>().removeFavorite(place);
                  },
                ),
              ),
            ],
          )
        : Center(
            child: InfoList(
              iconName: AppIcons.go,
              iconColor: textColor,
              title: Text(AppStrings.visitingEmpty),
              subtitle: Text(
                AppStrings.visitingVisitedEmpty,
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}
