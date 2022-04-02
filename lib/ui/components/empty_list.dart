import 'package:flutter/material.dart';
import 'package:places/ui/components/icon_box.dart';

/// Widget displaying a message about empty content
class EmptyList extends StatelessWidget {
  /// Creates widget, displaying [icon], [title] and [subtitle].
  ///
  /// [title] must be not null.
  const EmptyList({
    Key? key,
    this.iconName,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  final String? iconName;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;

    const double maxBoxWidth = 350;
    final double maxContentWidth = MediaQuery.of(context).size.width / 1.5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxBoxWidth),
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
