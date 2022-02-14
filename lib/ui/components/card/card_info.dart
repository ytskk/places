import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';

import 'card.dart';

Widget buildCardInfo(CardInfo cardInfo) {
  return DecoratedBox(
    decoration: BoxDecoration(color: AppColors.grayBackground),
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
                color: AppColors.textLabel,
              ),
            ),

            // subtitle
            if (cardInfo.subtitle != null && cardInfo.subtitle!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                  cardInfo.subtitle!,
                  style: TextStyle(
                    color:
                        cardInfo.subtitleColor ?? AppColors.textLabelSecondary,
                  ),
                ),
              ),
            // text
            if (cardInfo.text != null && cardInfo.text!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  cardInfo.text!,
                  style: TextStyle(
                    color: AppColors.textLabelSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
