import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/loading_progress_indicator.dart';
import 'package:places/ui/components/picker.dart';
import 'package:places/ui/components/sliding_tabbar.dart';
import 'package:places/ui/components/visiting/visiting_list_item.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    print('created favorites screen');
    context.read<FavoritesCubit>().loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          automaticallyImplyLeading: true,
          title: Text(AppStrings.visitingAppBarTitle),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(44),
            child: SlidingTabBar(
              tabs: AppStrings.visitingTabTitles,
            ),
          ),
        ),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (BuildContext context, state) {
            log('favorites screen state: $state');
            if (state is FavoritesLoadInitialInProgress ||
                state is FavoritesInitial) {
              return Center(
                child: LoadingProgressIndicator(),
              );
            }

            if (state is FavoritesLoadSuccess) {
              final List<Place> places = state.favorites;
              print(places);

              return _FavoritePlacesTabBarView(
                favoritePlaces: places,
                visitedPlaces: places.where((Place e) => e.isVisited).toList(),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _FavoritePlacesTabBarView extends StatelessWidget {
  const _FavoritePlacesTabBarView(
      {Key? key, required this.favoritePlaces, required this.visitedPlaces})
      : super(key: key);

  final List<Place> favoritePlaces;
  final List<Place> visitedPlaces;

  @override
  Widget build(BuildContext context) {
    final secondColor = Theme.of(context).textTheme.bodyText1!.color;

    return TabBarView(
      children: [
        _FavoritesReorderableList(
          items: _getFavoriteItems(context, favoritePlaces),
          emptyListData: InfoListData(
            iconName: AppIcons.card,
            iconColor: secondColor,
            title: Text(
              AppStrings.visitingEmpty,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            titleColor: secondColor,
            subtitle: Text(
              AppStrings.visitingWantToVisitEmpty,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        _FavoritesReorderableList(
          items: _getVisitedItems(context, visitedPlaces),
          emptyListData: InfoListData(
            iconName: AppIcons.go,
            iconColor: secondColor,
            title: Text(
              AppStrings.visitingEmpty,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            titleColor: secondColor,
            subtitle: Text(
              AppStrings.visitingVisitedEmpty,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class _FavoritesReorderableList extends StatefulWidget {
  const _FavoritesReorderableList({
    Key? key,
    required this.items,
    required this.emptyListData,
  }) : super(key: key);

  final List<Widget> items;
  final InfoListData emptyListData;

  @override
  State<_FavoritesReorderableList> createState() =>
      _FavoritesReorderableListState();
}

class _FavoritesReorderableListState extends State<_FavoritesReorderableList> {
  @override
  Widget build(BuildContext context) {
    return widget.items.isNotEmpty
        ? ReorderableListView(
            padding: const EdgeInsets.all(16),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = widget.items.removeAt(oldIndex);
                widget.items.insert(newIndex, item);
              });
            },
            children: [
              ...widget.items,
            ],
          )
        : Center(
            child: InfoList(
              infoListData: widget.emptyListData,
            ),
          );
  }
}

List<Widget> _getFavoriteItems(BuildContext context, List<Place> items) {
  return items
      .map((place) => VisitingListItem(
            key: ValueKey(place),
            place: place,
            cardActions: [
              Button.icon(
                icon: AppIcons.calendar,
                iconColor: Colors.white,
                background: Colors.transparent,
                onPressed: () async {
                  DateTime? plannedAt = await Picker.Adaptive(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  ).show(context);

                  context.read<FavoritesCubit>().setPlannedAt(place, plannedAt);
                },
              ),
            ],
            isVisited: true,
            scheduledAt: place.plannedAt,
            workingStatus: '${AppStrings.visitingVisitedClosedUntil} 09:00',
            onDeleteButtonPressed: () {
              context.read<FavoritesCubit>().removeFromFavorites(place);
            },
          ))
      .toList();
}

List<Widget> _getVisitedItems(BuildContext context, List<Place> items) {
  return items
      .map((place) => VisitingListItem(
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
            workingStatus: '${AppStrings.visitingVisitedClosedUntil} 09:00',
            onDeleteButtonPressed: () {
              context.read<FavoritesInteractor>().removeFromFavorites(place);
            },
          ))
      .toList();
}
