import 'package:flutter/material.dart';

import '../../domain/app_colors.dart';
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
    const double maxBoxWidth = 300;
    final double maxContentWidth = MediaQuery.of(context).size.width / 1.75;

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
                    color: Theme.of(context).textTheme.bodyText1!.color,
                    width: 64,
                    height: 64,
                  ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
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
                      style: Theme.of(context).textTheme.bodyText1,
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
