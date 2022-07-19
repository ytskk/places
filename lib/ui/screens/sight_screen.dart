import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/data/blocs/favorites/favorites_cubit.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/places_filter_request_dto.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/sight_card.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/loading_progress_indicator.dart';
import 'package:places/ui/components/searchbar.dart';
import 'package:places/ui/navigation/app_route_names.dart';

class SightScreen extends StatefulWidget {
  const SightScreen({Key? key}) : super(key: key);

  @override
  _SightScreenState createState() => _SightScreenState();
}

class _SightScreenState extends State<SightScreen> {
  @override
  void initState() {
    super.initState();

    log('SightScreen: initState');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const _AddPlaceFloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        top: false,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              _SightListSliverAppBar(isScrolled: innerBoxIsScrolled),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () async {
              final filterOptions = context.read<FilterCubit>().state;
              context.read<PlacesBloc>().add(
                    PlacesLoad(
                      filterOptions: PlacesFilterRequestDto(
                        typeFilter: filterOptions.getSelectedOptions(),
                        lat: 12.0,
                        lng: 17.0,
                        radius: filterOptions.radiusValues.end,
                      ),
                      radiusFrom: filterOptions.radiusValues.start,
                    ),
                  );
            },
            child: CustomScrollView(
              slivers: [
                const _PlacesList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlacesList extends StatelessWidget {
  const _PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (BuildContext context, state) {
        if (state is PlacesLoadInitial) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: const LoadingProgressIndicator(),
          );
        }

        if (state is PlacesLoadSuccess) {
          final places = state.places;

          if (places.isEmpty) {
            return SliverFillRemaining(
              hasScrollBody: false,
              child: const _PlacesNotFound(),
            );
          }

          return _PlaceList(places: places);
        }

        if (state is PlacesLoadFailure) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: const _PlacesNotFound(),
          );
        }

        return SliverFillRemaining(
          hasScrollBody: false,
          child: const Center(
            child: Text('Unknown state :('),
          ),
        );
      },
    );
  }
}

class _PlacesNotFound extends StatelessWidget {
  const _PlacesNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).textTheme.bodyText2!.color;

    return Center(
      child: InfoList(
        infoListData: InfoListData(
          iconName: AppIcons.delete,
          iconColor: iconColor,
          title: Text(
            AppStrings.emptyListTitle,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            AppStrings.emptyListSubtitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _PlaceList extends StatelessWidget {
  const _PlaceList({
    Key? key,
    required this.places,
  }) : super(key: key);

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 78),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Align(
            alignment: Alignment.topLeft,
            child: _PlaceListItem(
              place: places.elementAt(index),
            ),
          ),
          childCount: places.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 36.0,
          mainAxisSpacing: 16.0,
          mainAxisExtent: 200,
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 1
                  : 2,
        ),
      ),
    );
  }
}

class _PlaceListItem extends StatelessWidget {
  const _PlaceListItem({
    Key? key,
    required this.place,
  }) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    return SightCard(
      place,
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouteNames.placeDetails,
          arguments: place.id.toString(),
        );
      },
      actions: [
        _SightHeartIconButtonToggleable(
          place: place,
        ),
      ],
    );
  }
}

class _SightHeartIconButtonToggleable extends StatefulWidget {
  _SightHeartIconButtonToggleable({
    Key? key,
    required this.place,
  }) : super(key: key);

  final Place place;

  @override
  State<_SightHeartIconButtonToggleable> createState() =>
      __SightHeartIconButtonToggleableState();
}

class __SightHeartIconButtonToggleableState
    extends State<_SightHeartIconButtonToggleable> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return StreamBuilder(
          stream: context
              .read<FavoritesCubit>()
              .isFavorite(widget.place)
              .asStream(),
          initialData: false,
          builder: (_, AsyncSnapshot<dynamic> snapshot) {
            return IconButton(
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(widget.place);
                },
                icon: AnimatedCrossFade(
                  crossFadeState: snapshot.data
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: IconBox(
                    icon: AppIcons.heartFilled,
                    color: Colors.white,
                  ),
                  duration: quickDuration,
                  secondChild: IconBox(
                    icon: AppIcons.heart,
                    color: Colors.white,
                  ),
                ));
            // return Button.icon(
            //   icon: snapshot.data ?? false
            //       ? AppIcons.heartFilled
            //       : AppIcons.heart,
            //   iconColor: Colors.white,
            //   background: Colors.transparent,
            //   onPressed: () {
            //     context.read<FavoritesCubit>().toggleFavorite(widget.place);
            //   },
            // );
          },
        );
      },
    );
  }
}

class _SightListSliverAppBar extends StatelessWidget {
  /// Creates sliver app bar for sight list screen with hiding title.
  ///
  /// [isScrolled] is true when the app bar is collapsed, title is shown,
  /// otherwise, hidden.
  const _SightListSliverAppBar({
    Key? key,
    required this.isScrolled,
  }) : super(key: key);

  final bool isScrolled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      pinned: true,
      elevation: 0,
      expandedHeight: 212,
      automaticallyImplyLeading: false,
      title: AnimatedOpacity(
        opacity: isScrolled ? 1 : 0,
        duration: Duration(milliseconds: 150),
        child: Text(
          AppStrings.sightTitle,
          style: theme.textTheme.bodyText2!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Text(
                AppStrings.sightTitleExpanded,
                style: theme.textTheme.bodyText2!.copyWith(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SearchBar(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouteNames.search);
              },
              suffix: IconButton(
                padding: EdgeInsets.zero,
                icon: IconBox(
                  icon: AppIcons.filter,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRouteNames.filter);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Floating button for adding a new place.
class _AddPlaceFloatingButton extends StatelessWidget {
  /// Creates a floating action button for adding a new place.
  const _AddPlaceFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonWithGradient(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
          const SizedBox(width: smallSpacing),
          Text(
            AppStrings.sightFloatingButtonLabel.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(
          AppRouteNames.addNewPlace,
        );
      },
    );
  }
}
