import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/card/card.dart';

class SightCard extends StatelessWidget {
  const SightCard(
    this.sight, {
    Key? key,
    this.actions = const [],
  }) : super(key: key);

  final Sight sight;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MyCard(
          sight,
          actions: actions,
          cardInfo: CardInfo(
            subtitle: '${AppStrings.sightClosedUntil} 09:00',
            title: sight.name,
          ),
        ),
      ),
    );
  }
}
