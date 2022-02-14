import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
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
    );
  }
}
