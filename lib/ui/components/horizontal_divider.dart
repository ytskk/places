import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dividerColor = Theme.of(context).textTheme.bodyText1!.color;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Divider(
        height: 0.8,
        color: dividerColor,
      ),
    );
  }
}
