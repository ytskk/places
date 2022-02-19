import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
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
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  _buildSightSubtitle(context),
                  if (sight.details.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        sight.details,
                        style: Theme.of(context).textTheme.bodyText2,
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

  Expanded _buildSightManipulationButton(
    BuildContext context, {
    required String iconName,
    String? text,
    bool isActive = true,
  }) {
    Widget buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconBox(
            icon: iconName,
            color: Theme.of(context).textTheme.bodyText2!.color,
          ),
        ),
        if (text != null)
          Text(
            text,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2!.color,
            ),
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
          color: Theme.of(context).cardColor,
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

  Padding _buildSightSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            sight.type,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w700),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              // temp
              'Закрыто до 09:00',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }

  // transparent appBar with rounded back button
  AppBar _buildAppBar(BuildContext context) {
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
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.back,
                color: Theme.of(context).textTheme.bodyText2!.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
