import 'package:flutter/material.dart';

Widget buildCardHeader(String title, {List<Widget> actions = const []}) {
  print("received actions: $actions");

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // sight type
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        // sight actions
        if (actions.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              for (var action in actions)
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: action,
                ),
            ],
          ),
      ],
    ),
  );
}
