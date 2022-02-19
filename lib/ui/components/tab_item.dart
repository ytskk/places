import 'package:flutter/material.dart';

class TabItem extends StatelessWidget {
  final String text;

  const TabItem({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget result = Tab(text: text);

    return result;
  }
}
