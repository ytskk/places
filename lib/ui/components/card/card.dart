import 'package:flutter/material.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/models/card_info.dart';
import 'package:places/ui/components/card/card_header.dart';
import 'package:places/ui/components/card/card_information.dart';
import 'package:places/ui/components/image/network_image_box.dart';

class MyCard extends StatelessWidget {
  /// Creates card widget.
  ///
  /// If card info is null, uses [place] data.
  MyCard(
    this.place, {
    Key? key,
    this.actions = const [],
    cardInfo,
    this.onTap,
  })  : this.cardInfo =
            cardInfo ?? CardInfo(title: place.name, text: place.description),
        super(key: key);

  /// Contains displayable card info.
  final CardInfo cardInfo;
  final Place place;

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
        Stack(
          alignment: Alignment.bottomCenter,
          // mainAxisSize: MainAxisSize.min,
          children: [
            // header + photo
            NetworkImageBox(place.urls.first, height: 200),
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
        CardHeader(title: place.type, actions: actions),
      ],
    );
  }
}
