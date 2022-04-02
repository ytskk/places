import 'package:flutter/material.dart';
import 'package:places/ui/components/card/card.dart';

class CardInformation extends StatelessWidget {
  const CardInformation({
    Key? key,
    required this.cardInfo,
  }) : super(key: key);

  final CardInfo cardInfo;

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).backgroundColor;
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: BoxDecoration(color: bgColor),
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
                style: textTheme.headline4,
              ),

              // subtitle
              if (cardInfo.subtitle != null && cardInfo.subtitle!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    cardInfo.subtitle!,
                    style: TextStyle(
                      color:
                          cardInfo.subtitleColor ?? textTheme.bodyText1!.color,
                    ),
                  ),
                ),
              // text
              if (cardInfo.text != null && cardInfo.text!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    cardInfo.text!,
                    style: textTheme.bodyText1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
