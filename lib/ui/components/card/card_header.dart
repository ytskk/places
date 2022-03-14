import 'package:flutter/material.dart';

Widget buildCardHeader(String title, {List<Widget> actions = const []}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // sight type
      Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // sight actions
      if (actions.isNotEmpty)
        ButtonBar(
          buttonPadding: EdgeInsets.zero,
          children: actions,
        ),
    ],
  );
}
