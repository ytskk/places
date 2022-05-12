import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/card_info.dart';
import 'package:places/ui/components/card/card.dart';

class SightCard extends StatelessWidget {
  const SightCard(
    this.place, {
    Key? key,
    this.actions = const [],
    this.onTap,
  }) : super(key: key);

  final Place place;
  final List<Widget> actions;

  /// Callback when clicking on any place on the card except for actions.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(smallBorderRadius)),
      child: MyCard(
        place,
        onTap: onTap,
        actions: actions,
        cardInfo: CardInfo(
          subtitle: '${AppStrings.sightClosedUntil} 09:00',
          title: place.name,
        ),
      ),
    );
  }
}
