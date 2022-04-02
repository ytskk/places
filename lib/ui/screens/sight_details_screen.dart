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
      appBar: CustomAppBar(
        background: Colors.transparent,
        leading: Navigator.canPop(context) ? const _RoundedBackButton() : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NetworkImageBox(sight.url, height: 420),
            SafeArea(
              // for better display in horizontal format
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
          ],
        ),
      ),
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
