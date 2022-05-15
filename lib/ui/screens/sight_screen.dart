import 'dart:async';

import 'package:flutter/material.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_routes.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/sight_card.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/loading_progress_indicator.dart';
import 'package:places/ui/components/searchbar.dart';
import 'package:provider/provider.dart';

class SightScreen extends StatefulWidget {
  const SightScreen({Key? key}) : super(key: key);

  @override
  _SightScreenState createState() => _SightScreenState();
}

class _SightScreenState extends State<SightScreen> {
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
          body: CustomScrollView(
            slivers: [
              _PlaceFutureList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceFutureList extends StatefulWidget {
  const _PlaceFutureList({Key? key}) : super(key: key);

  @override
  State<_PlaceFutureList> createState() => _PlaceFutureListState();
}

class _PlaceFutureListState extends State<_PlaceFutureList> {
  @override
  void initState() {
    super.initState();

    context.read<Filter>().getFilteredPlaces(context);
  }

  @override
  dispose() {
    super.dispose();
    context.read<Filter>().disposeStream();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<Place>>(
      stream: context.read<Filter>().filteredPlacesStream,
      initialData: [],
      builder: (_, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: LoadingProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: InfoList(
                  iconName: AppIcons.delete,
                  iconColor: theme.textTheme.bodyText1!.color,
                  title: Text(AppStrings.requestError),
                  titleColor: theme.textTheme.bodyText1!.color,
                  subtitle: Text(
                    AppStrings.sightLoadingError,
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
        }

        return _PlaceList(
          places: snapshot.data,
        );
      },
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
        Navigator.pushNamed(context, AppRoutes.sightDetails,
            arguments: place.id);
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
  late final StreamController<bool> _likeButtonController;

  @override
  initState() {
    super.initState();

    _likeButtonController = StreamController<bool>();
  }

  @override
  void dispose() {
    super.dispose();

    _likeButtonController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: _likeButtonController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Button.icon(
          icon: snapshot.data == true ? AppIcons.heartFilled : AppIcons.heart,
          iconColor: Colors.white,
          background: Colors.transparent,
          onPressed: () {
            // print("Wishlist icon clicked");
            // context.read<FavoritesInteractor>().toggleFavorite(widget.place);
            _likeButtonController.sink.add(!snapshot.data);
          },
        );
      },
    );
    // TODO: return
    // return FutureBuilder(
    //   future: context.watch<FavoritesInteractor>().isFavorite(widget.place),
    //   builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    //     return Button.icon(
    //       icon: snapshot.data == true ? AppIcons.heartFilled : AppIcons.heart,
    //       iconColor: Colors.white,
    //       background: Colors.transparent,
    //       onPressed: () {
    //         // print("Wishlist icon clicked");
    //         context.read<FavoritesInteractor>().toggleFavorite(widget.place);
    //       },
    //     );
    //   },
    // );
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
                Navigator.of(context).pushNamed(AppRoutes.search);
              },
              suffix: IconButton(
                padding: EdgeInsets.zero,
                icon: IconBox(
                  icon: AppIcons.filter,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.sightFilter);
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
          AppRoutes.addSight,
        );
      },
    );
  }
}
