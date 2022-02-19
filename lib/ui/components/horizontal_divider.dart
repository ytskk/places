import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Divider(
        height: 0.8,
        color: Theme.of(context).textTheme.bodyText1!.color,
      ),
    );
  }
}
