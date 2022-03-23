import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:places/ui/components/image/network_image_box.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(Sight this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        background: Colors.transparent,
        leading: Navigator.canPop(context) ? _RoundedBackButton() : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NetworkImageBox(sight.url, height: 420),
            SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // sight name
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        sight.name,
                        style: textTheme.headline3,
                      ),
                    ),
                    _buildSightSubtitle(context, sight.type),
                    if (sight.details.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Text(
                          sight.details,
                          style: textTheme.bodyText2,
                        ),
                      ),
                    // button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Button.icon(
                        buttonPadding: ButtonPadding.Wide,
                        text: AppStrings.sightDetailsGetDirections,
                        onPressed: () {
                          print("Direction button clicked");
                        },
                        icon: AppIcons.go,
                      ),
                    ),
                    const HorizontalDivider(),
                    Row(
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
                    ),
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

Widget _buildSightSubtitle(BuildContext context, String sightType) {
  final bodyText1 = Theme.of(context).textTheme.bodyText1;

  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Row(
      children: [
        Text(
          sightType,
          style: bodyText1!.copyWith(fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            // temp
            'Закрыто до 09:00',
            style: bodyText1,
          ),
        ),
      ],
    ),
  );
}

class _RoundedBackButton extends StatelessWidget {
  const _RoundedBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          backgroundColor: theme.backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          print("Back button clicked");
          Navigator.pop(context);
        },
        child: Icon(
          CupertinoIcons.back,
          color: theme.textTheme.bodyText2!.color,
        ),
      ),
    );
  }
}
