import 'package:flutter/material.dart';

class CardHeader extends StatelessWidget {
  const CardHeader({
    Key? key,
    this.title,
    this.actions = const [],
  }) : super(key: key);

  final String? title;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // sight type
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title!,
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
}
