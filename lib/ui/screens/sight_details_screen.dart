import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/ui/components/icon_box.dart';

import '../components/horizontal_divider.dart';

class SightDetails extends StatelessWidget {
  final Sight sight;

  const SightDetails(Sight this.sight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildImage(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // sight name
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      sight.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF3B3E5B),
                      ),
                    ),
                  ),
                  _buildSightSubtitle(),
                  if (sight.details.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Text(
                        sight.details,
                        style: TextStyle(color: AppColors.textLabel),
                      ),
                    ),
                  // button
                  _buildDirectionButton(),
                  HorizontalDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSightManipulationButton(
                        iconName: AppIcons.calendar,
                        text: AppStrings.sightDetailsSchedule,
                        isActive: false,
                      ),
                      _buildSightManipulationButton(
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

  Expanded _buildSightManipulationButton({
    required String iconName,
    String? text,
    bool isActive = true,
  }) {
    Widget buttonContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconContainer(
            icon: iconName,
            color: AppColors.textLabel,
          ),
        ),
        if (text != null)
          Text(
            text,
            style: TextStyle(
              color: AppColors.textLabel,
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

  Padding _buildDirectionButton() {
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
          color: AppColors.green,
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

  Padding _buildSightSubtitle() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Text(
            sight.type,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.textLabel,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              // temp
              'Закрыто до 09:00',
              style: TextStyle(
                color: AppColors.textLabelSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _buildImage() {
    return SizedBox(
      height: 360,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            sight.url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return Center(
                child: CupertinoActivityIndicator.partiallyRevealed(
                  progress: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : 1,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return DecoratedBox(
                decoration: BoxDecoration(color: Colors.red),
              );
            },
          ),
          Opacity(
            opacity: 0.4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff252849),
                    Color.fromRGBO(59, 62, 91, 0.08),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Container(
        margin: EdgeInsets.only(top: 16),
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 32,
          width: 32,
          // margin: EdgeInsets.all(12),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                CupertinoIcons.back,
                color: AppColors.textLabel,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
