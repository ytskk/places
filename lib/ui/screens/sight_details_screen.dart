import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:places/ui/components/image/network_image_box.dart';
import 'package:places/ui/components/loading_progress_indicator.dart';
import 'package:places/ui/components/picker.dart';
import 'package:places/utils/extensions/list_extension.dart';
import 'package:places/utils/screen_sizes.dart';
import 'package:places/utils/string_manipulations.dart';

/// A page detailing the [Place].
class SightDetailsScreen extends StatefulWidget {
  const SightDetailsScreen({
    key,
  }) : super(key: key);

  @override
  State<SightDetailsScreen> createState() => _SightDetailsScreenState();
}

class _SightDetailsScreenState extends State<SightDetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    context.read<PlaceDetailsCubit>().loadPlaceDetails(
          ModalRoute.of(context)!.settings.arguments as String,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceDetailsCubit, PlaceDetailsState>(
        builder: (BuildContext context, state) {
          if (state is PlaceDetailsLoadInProgress) {
            return _PlaceDetailsLoadInProgress();
          }

          if (state is PlaceDetailsLoadSuccess) {
            final sight = state.placeDetails;

            return _PlaceDetailsLoadSuccess(sight: sight);
          }

          if (state is PlaceDetailsLoadFailure) {
            return _PlaceDetailsLoadFailure(error: state.error.toString());
          }

          return Center(
            child: const Text('Если бы мы знали что это такое…'),
          );
        },
      ),
    );
  }
}

class _PlaceDetailsLoadInProgress extends StatelessWidget {
  const _PlaceDetailsLoadInProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const LoadingProgressIndicator(),
    );
  }
}

class _PlaceDetailsLoadSuccess extends StatelessWidget {
  const _PlaceDetailsLoadSuccess({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Place sight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CustomScrollView(
        primary: false,
        slivers: [
          _SightSliverAppBar(
            sight: sight,
            sightImages: sight.urls.isEmpty
                ? [ListExtension(sight.urls).takeFirstImgOrTemp]
                : sight.urls,
            useBackButton: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SafeArea(
                top: false,
                child: Padding(
                  padding: largeWrappingPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          sight.name,
                          style: textTheme.headline3,
                        ),
                      ),
                      _SightSubtitle(
                        sightType: sight.type.name,
                        sightWorkingStatus:
                            '${AppStrings.sightDetailsWorkingStatusClosed} 9:00',
                      ),
                      if (sight.description != null &&
                          sight.description!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Text(
                            sight.description!,
                            style: textTheme.bodyText2,
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: _DirectionButton(),
                      ),
                      const HorizontalDivider(),
                      _SightManipulationButtons(
                        place: sight,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class _PlaceDetailsLoadFailure extends StatelessWidget {
  const _PlaceDetailsLoadFailure({
    Key? key,
    required this.error,
  }) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Text(
        '${error.toString()}',
        style: textTheme.headline3,
      ),
    );
  }
}

class _SightSliverAppBar extends StatelessWidget {
  const _SightSliverAppBar({
    Key? key,
    required this.sightImages,
    required this.useBackButton,
    required this.sight,
  }) : super(key: key);

  final List<String> sightImages;
  final bool useBackButton;
  final Place sight;

  @override
  Widget build(BuildContext context) {
    final isImagesEmpty = sightImages.isEmpty;

    return SliverAppBar(
      leading: useBackButton ? const _RoundedBackButton() : null,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: isImagesEmpty ? 0 : 360,
      flexibleSpace: isImagesEmpty
          ? null
          : FlexibleSpaceBar(
              background: _ImagesCarousel(
                images: sightImages,
              ),
            ),
    );
  }
}

/// Sight images carousel view with slide indicator.
class _ImagesCarousel extends StatefulWidget {
  /// Shows [images] in carousel.
  ///
  /// If [images] length is less than 2, indicator is not shown.
  const _ImagesCarousel({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List<String> images;

  @override
  State<_ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<_ImagesCarousel> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        PageView.builder(
          onPageChanged: (index) => setState(() => _currentPage = index),
          itemCount: widget.images.length,
          itemBuilder: (context, index) => NetworkImageBox(
            widget.images[index],
          ),
        ),
        if (widget.images.length > 1)
          _SightImagesCarouselIndicator(
            imagesCount: widget.images.length,
            currentPage: _currentPage,
          ),
      ],
    );
  }
}

class _SightImagesCarouselIndicator extends StatelessWidget {
  const _SightImagesCarouselIndicator({
    Key? key,
    required this.imagesCount,
    required this.currentPage,
  }) : super(key: key);

  final int imagesCount;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    final indicatorColor = Theme.of(context).textTheme.bodyText2!.color;

    // images indicator, which is expanded to full width.
    return Row(
      children: [
        for (int pageIndex = 0; pageIndex < imagesCount; pageIndex += 1)
          Expanded(
            child: SizedBox(
              height: 8.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: pageIndex == currentPage
                      ? indicatorColor
                      : Colors.transparent,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SightSubtitle extends StatelessWidget {
  const _SightSubtitle({
    Key? key,
    required this.sightType,
    this.sightWorkingStatus,
  }) : super(key: key);

  final String sightType;
  final String? sightWorkingStatus;

  @override
  Widget build(BuildContext context) {
    final subtitleTextStyle = Theme.of(context).textTheme.bodyText1;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            sightType,
            style: subtitleTextStyle!.copyWith(fontWeight: FontWeight.w700),
          ),
          if (sightWorkingStatus != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                sightWorkingStatus!,
                style: subtitleTextStyle,
              ),
            ),
        ],
      ),
    );
  }
}

class _DirectionButton extends StatelessWidget {
  const _DirectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button.icon(
      buttonPadding: ButtonPadding.Wide,
      text: AppStrings.sightDetailsGetDirections,
      onPressed: () {
        print("Direction button clicked");
      },
      icon: AppIcons.go,
    );
  }
}

class _SightManipulationButtons extends StatelessWidget {
  const _SightManipulationButtons({
    Key? key,
    required this.place,
  }) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    final screenDependentFontSize = _getScreenDependentFontSize(context);
    final screenDependentIconSize = screenDependentFontSize != null
        ? screenDependentFontSize * 1.72
        : smallIconSize;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Button.icon(
            icon: AppIcons.calendar,
            iconSize: screenDependentIconSize,
            text: place.plannedAt != null
                ? '${formatDate(
                    place.plannedAt!,
                    pattern: DateFormats.dayShortMonthYearDateFormat,
                  )}'
                : AppStrings.sightDetailsSchedule,
            textStyle: TextStyle(
              fontSize: screenDependentFontSize,
            ),
            background: Colors.transparent,
            onPressed: () async {
              DateTime? remindDate = await Picker.Adaptive(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              ).show(context);

              log('Remind date: $remindDate', name: 'SightManipulationButtons');

              // context
              //     .read<FavoritesInteractor>()
              //     .setPlannedAt(place, remindDate);
            },
          ),
        ),
        Expanded(
          child: FutureBuilder(
            // future: context.watch<FavoritesInteractor>().isFavorite(place),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return Button.icon(
                icon: snapshot.data == true
                    ? AppIcons.heartFilled
                    : AppIcons.heart,
                iconSize: screenDependentIconSize,
                text: snapshot.data == true
                    ? AppStrings.sightDetailsInWishlist
                    : AppStrings.sightDetailsAddToWishlist,
                textStyle: TextStyle(
                  fontSize: screenDependentFontSize,
                ),
                background: Colors.transparent,
                onPressed: () {
                  log("To Wishlist button clicked");
                  // context.read<FavoritesInteractor>().toggleFavorite(place);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

double? _getScreenDependentFontSize(BuildContext context) {
  final screenWidth = resolveScreenWidthSize(MediaQuery.of(context).size.width);

  switch (screenWidth) {
    case ScreenSizes.Small:
      return 12;
    case ScreenSizes.Large:
      return 17;

    default:
      return null;
  }
}

/// Creates rounded back button.
class _RoundedBackButton extends StatelessWidget {
  /// Rounded button with [Navigator.pop(context)] onPressed action.
  const _RoundedBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: SizedBox(
          height: 44,
          width: 44,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: InkWell(
                splashColor: Colors.black12,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  CupertinoIcons.back,
                  color: theme.textTheme.bodyText2!.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
