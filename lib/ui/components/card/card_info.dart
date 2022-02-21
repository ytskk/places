import 'package:flutter/material.dart';

import 'card.dart';

Widget buildCardInfo(CardInfo cardInfo, BuildContext context) {
  final theme = Theme.of(context);

  return DecoratedBox(
    decoration: BoxDecoration(color: theme.backgroundColor),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: double.infinity),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            Text(
              cardInfo.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            // subtitle
            if (cardInfo.subtitle != null && cardInfo.subtitle!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  cardInfo.subtitle!,
                  style: TextStyle(
                    color: cardInfo.subtitleColor ??
                        theme.textTheme.bodyText1!.color,
                  ),
                ),
              ),
            // text
            if (cardInfo.text != null && cardInfo.text!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  cardInfo.text!,
                  style: theme.textTheme.bodyText1,
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
