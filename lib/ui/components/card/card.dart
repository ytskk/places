import 'package:flutter/material.dart';
import 'package:places/models/card_info.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/card/card_header.dart';
import 'package:places/ui/components/card/card_information.dart';
import 'package:places/ui/components/image/network_image_box.dart';

class MyCard extends StatelessWidget {
  /// Creates card widget.
  ///
  /// If card info is null, uses [sight] data.
  MyCard(
    this.sight, {
    Key? key,
    this.actions = const [],
    cardInfo,
    this.onTap,
  })  : this.cardInfo =
            cardInfo ?? CardInfo(title: sight.name, text: sight.details),
        super(key: key);

  /// Contains displayable card info.
  final CardInfo cardInfo;
  final Sight sight;

  /// Top right list of widgets, typically buttons.
  final List<Widget> actions;

  /// Callback when clicking on any place on the card except for actions.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final splashColor =
        Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.2);

    return Stack(
      children: [
        Column(
          children: [
            // header + photo
            Stack(
              children: [
                // photo
                NetworkImageBox(sight.url, height: 96),
              ],
            ),
            // card info
            CardInformation(cardInfo: cardInfo),
          ],
        ),
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              splashColor: splashColor,
              onTap: onTap,
            ),
          ),
        ),
        // text + action buttons
        CardHeader(title: sight.type, actions: actions),
      ],
    );
  }
}
