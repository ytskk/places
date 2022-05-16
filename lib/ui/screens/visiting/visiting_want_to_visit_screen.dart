import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/data/api/network_exception.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/loading_progress_indicator.dart';
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
  late StreamController<List<Place>> _placesController;

  @override
  void initState() {
    super.initState();

    _placesController = StreamController<List<Place>>();
    getPlaces();
  }

  Future getPlaces() async {
    _placesController.sink
        .addError(NetworkException(name: 'Wrong Data', message: 'Wrong Data'));
  }

  @override
  void dispose() {
    super.dispose();

    _placesController.close();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final List<Place> favoritesPlaces = [];

    return StreamBuilder<List<Place>>(
        stream: _placesController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: InfoList(
                iconName: AppIcons.delete,
                iconColor: theme.textTheme.bodyText1!.color,
                title: Text(
                  snapshot.error!.toString(),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return _VisitingReorderableList(favoritesPlaces: favoritesPlaces);
        });
  }
}

class _VisitingReorderableList extends StatefulWidget {
  const _VisitingReorderableList({
    Key? key,
    required this.favoritesPlaces,
  }) : super(key: key);

  final List<Place> favoritesPlaces;

  @override
  State<_VisitingReorderableList> createState() =>
      _VisitingReorderableListState();
}

class _VisitingReorderableListState extends State<_VisitingReorderableList> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: const EdgeInsets.all(16),
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final Place item = widget.favoritesPlaces.removeAt(oldIndex);
          widget.favoritesPlaces.insert(newIndex, item);
        });
      },
      children: [
        ...widget.favoritesPlaces.map(
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
  }
}
