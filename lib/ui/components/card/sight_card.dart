import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/card/card.dart';

class SightCard extends StatelessWidget {
  const SightCard(
    Sight this.sight, {
    Key? key,
    List<Widget> this.actions = const [],
  }) : super(key: key);

  final Sight sight;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return MyCard(
      sight,
      actions: actions,
      cardInfo: CardInfo(subtitle: "закрыто до 09:00", title: sight.name),
    );
  }
}
