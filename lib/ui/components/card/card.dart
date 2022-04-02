import 'package:flutter/material.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/card/card_header.dart';
import 'package:places/ui/components/card/card_info.dart';
import 'package:places/ui/components/image/network_image_box.dart';

class CardInfo {
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final String? text;

  const CardInfo({
    required String this.title,
    String? this.text,
    String? this.subtitle,
    Color? this.subtitleColor,
  });
}

class MyCard extends StatelessWidget {
  final CardInfo cardInfo;
  final Sight sight;
  final List<Widget> actions;

  MyCard(
    Sight this.sight, {
    Key? key,
    List<Widget> this.actions = const [],
    CardInfo? cardInfo,
  })  : this.cardInfo =
            cardInfo ?? CardInfo(title: sight.name, text: sight.details),
        super(key: key);

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
            buildCardInfo(cardInfo, context),
          ],
        ),
        Positioned.fill(
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              splashColor: splashColor,
              onTap: () {
                print("Card clicked");
              },
            ),
          ),
        ),
        // text + action buttons
        buildCardHeader(sight.type, actions: actions),
      ],
    );
  }
}
