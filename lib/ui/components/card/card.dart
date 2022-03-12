import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          log("Card clicked");
        },
        child: ClipRRect(
          clipBehavior: Clip.hardEdge,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              // header + photo
              Stack(
                children: [
                  // photo
                  NetworkImageBox(sight.url, height: 96, context: context),
                  // text + action buttons
                  buildCardHeader(sight.type, actions: actions),
                ],
              ),
              // card info
              buildCardInfo(cardInfo, context),
            ],
          ),
        ),
      ),
    );
  }
}
