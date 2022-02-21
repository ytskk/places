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
    final bodyText2 = Theme.of(context).textTheme.bodyText2;

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
                      style: bodyText2!.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  _buildSightSubtitle(context, sight.type),
                  if (sight.details.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        sight.details,
                        style: bodyText2,
                      ),
                    ),
                  // button
                  _buildDirectionButton(context),
                  HorizontalDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSightManipulationButton(
                        context,
                        iconName: AppIcons.calendar,
                        text: AppStrings.sightDetailsSchedule,
                        isActive: false,
                      ),
                      _buildSightManipulationButton(
                        context,
                        iconName: AppIcons.heart,
                        text: AppStrings.sightDetailsAddToWishlist,
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

Expanded _buildSightManipulationButton(
  BuildContext context, {
  required String iconName,
  String? text,
  bool isActive = true,
}) {
  final bodyText2 = Theme.of(context).textTheme.bodyText2;

  Widget buttonContent = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: IconBox(
          icon: iconName,
          color: bodyText2!.color,
        ),
      ),
      if (text != null)
        Text(
          text,
          style: bodyText2,
        ),
    ],
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

Padding _buildDirectionButton(BuildContext context) {
  final themeColor = Theme.of(context);

  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    // cos using alignment, constraints and decoration
    child: Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        minHeight: 48,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: themeColor.cardColor,
      ),
      child: Text(
        AppStrings.sightDetailsGetDirections.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Padding _buildSightSubtitle(BuildContext context, String sightType) {
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
AppBar _buildAppBar(BuildContext context) {
  final theme = Theme.of(context);

  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 32,
        width: 32,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              CupertinoIcons.back,
              color: theme.textTheme.bodyText2!.color,
            ),
          ),
        ),
      ),
    ),
  );
}
