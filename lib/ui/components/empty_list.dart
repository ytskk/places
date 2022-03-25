import 'package:flutter/material.dart';

import 'icon_box.dart';

class EmptyList extends StatelessWidget {
  final String? iconName;
  final String title;
  final String? subtitle;

  const EmptyList({
    Key? key,
    String? this.iconName,
    required String this.title,
    String? this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;

    const double maxBoxWidth = 350;
    final double maxContentWidth = MediaQuery.of(context).size.width / 1.5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxBoxWidth),
          child: SizedBox(
            width: maxContentWidth,
            child: Column(
              children: [
                if (iconName != null)
                  IconBox(
                    icon: iconName!,
                    color: bodyText1!.color,
                    size: 64,
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    title,
                    style: bodyText1!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style: bodyText1,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
