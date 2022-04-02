import 'package:flutter/material.dart';

/// Custom designed [Tab].
class TabItem extends StatelessWidget {
  const TabItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    Widget result = Tab(text: text);

    return result;
  }
}
