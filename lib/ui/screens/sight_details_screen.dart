import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/ui/components/image/network_image_box.dart';

import '../components/horizontal_divider.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(Sight this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NetworkImageBox(sight.url, height: 420, context: context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                    child: _buildDirectionButton(context, () {
                      print("Direction button clicked");
                    }),
                  ),
                  HorizontalDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSightManipulationButton(
                        context,
                        iconName: AppIcons.calendar,
                        text: AppStrings.sightDetailsSchedule,
                        onPressed: () {
                          print("Plan button clicked");
                        },
                        isActive: false,
                      ),
                      _buildSightManipulationButton(
                        context,
                        iconName: AppIcons.heart,
                        text: AppStrings.sightDetailsAddToWishlist,
                        onPressed: () {
                          print("To Wishlist button clicked");
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildSightManipulationButton(
  BuildContext context, {
  String? iconName,
  required String text,
  required Function() onPressed,
  bool isActive = true,
}) {
  final bodyText2 = Theme.of(context).textTheme.bodyText2;

  Widget buttonContent = iconName != null
      ? TextButton.icon(
          onPressed: isActive ? onPressed : null,
          icon: IconBox(icon: iconName, color: bodyText2!.color),
          label: Text(text, style: bodyText2),
        )
      : TextButton(
          onPressed: isActive ? onPressed : null,
          child: Text(
            text,
            style: bodyText2,
          ),
        );

  Widget child = isActive
      ? buttonContent
      : Opacity(
          opacity: 0.4,
          child: buttonContent,
        );

  return Expanded(
    child: Center(
      child: child,
    ),
  );
}

Widget _buildDirectionButton(BuildContext context, Function() onPressed) {
  final theme = Theme.of(context);

  return TextButton.icon(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: theme.cardColor,
      padding: EdgeInsets.all(16),
    ),
    label: Text(
      AppStrings.sightDetailsGetDirections,
      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
    ),
    icon: IconBox(
      icon: AppIcons.go,
    ),
  );
  // return Padding(
  //   padding: const EdgeInsets.only(bottom: 16),
  //   // cos using alignment, constraints and decoration
  //   child: Container(
  //     alignment: Alignment.center,
  //     constraints: BoxConstraints(
  //       minHeight: 48,
  //     ),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12),
  //       color: themeColor.cardColor,
  //     ),
  //     child: Text(
  //       AppStrings.sightDetailsGetDirections.toUpperCase(),
  //       style: TextStyle(
  //         fontWeight: FontWeight.w700,
  //         color: Colors.white,
  //       ),
  //     ),
  //   ),
  // );
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

// transparent appBar with rounded back button
PreferredSizeWidget _buildAppBar(BuildContext context) {
  final theme = Theme.of(context);

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
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
        },
        child: Icon(
          CupertinoIcons.back,
          color: theme.textTheme.bodyText2!.color,
        ),
      ),
    ),
  );
}
