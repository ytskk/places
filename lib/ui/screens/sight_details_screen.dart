import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:places/ui/components/image/network_image_box.dart';

/// A page detailing the [Sight].
class SightDetails extends StatelessWidget {
  /// Detailed page for provided [sight].
  const SightDetails(Sight this.sight, {Key? key}) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          _SightSliverAppBar(sight: sight),
          SliverList(
            delegate: SliverChildListDelegate([
              SafeArea(
                // for better display in horizontal format
                // top: isImagesEmpty,
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
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
                        sightType: sight.type,
                        sightWorkingStatus:
                            '${AppStrings.sightDetailsWorkingStatusClosed} 9:00',
                      ),
                      if (sight.details.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Text(
                            sight.details,
                            style: textTheme.bodyText2,
                          ),
                        ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: _DirectionButton(),
                      ),
                      const HorizontalDivider(),
                      const _SightManipulationButtons(),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          // SingleChildScrollView(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(bottom: 4),
          //           child: Text(
          //             sight.name,
          //             style: textTheme.headline3,
          //           ),
          //         ),
          //         _SightSubtitle(
          //           sightType: sight.type,
          //           sightWorkingStatus:
          //               '${AppStrings.sightDetailsWorkingStatusClosed} 9:00',
          //         ),
          //         if (sight.details.isNotEmpty)
          //           Padding(
          //             padding: const EdgeInsets.only(bottom: 24),
          //             child: Text(
          //               sight.details,
          //               style: textTheme.bodyText2,
          //             ),
          //           ),
          //         const Padding(
          //           padding: EdgeInsets.only(bottom: 8),
          //           child: _DirectionButton(),
          //         ),
          //         const HorizontalDivider(),
          //         const _SightManipulationButtons(),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
      //   body: SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         // if sight has image, show it
      //         if (sight.images.isNotEmpty)
      //           _SightImagesCarousel(
      //             sightImages: sight.images,
      //           ),
      //         SafeArea(
      //           // for better display in horizontal format
      //           top: sight.images.isEmpty,
      //           child: Padding(
      //             padding:
      //                 const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.stretch,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.only(bottom: 4),
      //                   child: Text(
      //                     sight.name,
      //                     style: textTheme.headline3,
      //                   ),
      //                 ),
      //                 _SightSubtitle(
      //                   sightType: sight.type,
      //                   sightWorkingStatus:
      //                       '${AppStrings.sightDetailsWorkingStatusClosed} 9:00',
      //                 ),
      //                 if (sight.details.isNotEmpty)
      //                   Padding(
      //                     padding: const EdgeInsets.only(bottom: 24),
      //                     child: Text(
      //                       sight.details,
      //                       style: textTheme.bodyText2,
      //                     ),
      //                   ),
      //                 const Padding(
      //                   padding: EdgeInsets.only(bottom: 8),
      //                   child: _DirectionButton(),
      //                 ),
      //                 const HorizontalDivider(),
      //                 const _SightManipulationButtons(),
      //               ],
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
    );
  }
}

class _SightSliverAppBar extends StatelessWidget {
  const _SightSliverAppBar({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    final isImagesEmpty = sight.images.isEmpty;

    return SliverAppBar(
      leading: Navigator.canPop(context) ? const _RoundedBackButton() : null,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: isImagesEmpty ? 0 : 360,
      flexibleSpace: isImagesEmpty
          ? null
          : FlexibleSpaceBar(
              background: _SightImagesCarousel(
                sightImages: sight.images,
              ),
            ),
    );
  }
}

/// Sight images carousel view with slide indicator.
class _SightImagesCarousel extends StatefulWidget {
  /// Shows [sightImages] in carousel.
  ///
  /// If [sightImages] length is less than 2, indicator is not shown.
  const _SightImagesCarousel({
    Key? key,
    required this.sightImages,
  }) : super(key: key);

  final List<String> sightImages;

  @override
  State<_SightImagesCarousel> createState() => _SightImagesCarouselState();
}

class _SightImagesCarouselState extends State<_SightImagesCarousel> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        PageView.builder(
          onPageChanged: (index) => setState(() => _currentPage = index),
          itemCount: widget.sightImages.length,
          itemBuilder: (context, index) => NetworkImageBox(
            widget.sightImages[index],
          ),
        ),
        if (widget.sightImages.length > 1)
          _SightImagesCarouselIndicator(
            imagesCount: widget.sightImages.length,
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
        for (int i = 0; i < imagesCount; i += 1)
          Expanded(
            child: SizedBox(
              height: 8.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: i == currentPage ? indicatorColor : Colors.transparent,
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
  const _SightManipulationButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Button.icon(
            icon: AppIcons.calendar,
            text: AppStrings.sightDetailsSchedule,
            background: Colors.transparent,
          ),
        ),
        Expanded(
          child: Button.icon(
            icon: AppIcons.heart,
            text: AppStrings.sightDetailsAddToWishlist,
            background: Colors.transparent,
            onPressed: () {
              print("To Wishlist button clicked");
            },
          ),
        ),
      ],
    );
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
              borderRadius: BorderRadius.circular(10),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                splashColor: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  print("Back button clicked");
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
