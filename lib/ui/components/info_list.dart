import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/ui/components/icon_box.dart';

/// Widget displaying a message content
class InfoList extends StatelessWidget {
  /// Creates widget, displaying [icon], [title] and [subtitle].
  ///
  /// [title] must be not null.
  const InfoList({
    Key? key,
    this.iconName,
    this.iconColor,
    this.iconSize = 64,
    this.iconPaddingBottom = 24,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  final String? iconName;
  final Color? iconColor;
  final double iconSize;
  final double iconPaddingBottom;
  final Text title;
  final Text? subtitle;

  @override
  Widget build(BuildContext context) {
    // final defaultIconColor = Theme.of(context).
    final defaultTitleStyle =
        Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 24);
    final defaultSubtitleStyle = Theme.of(context).textTheme.bodyText1;

    final double maxContentWidth = MediaQuery.of(context).size.width / 1.5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxBoxWidth),
          child: SizedBox(
            width: maxContentWidth,
            child: Column(
              children: [
                if (iconName != null)
                  Padding(
                    padding: EdgeInsets.only(bottom: iconPaddingBottom),
                    child: IconBox(
                      icon: iconName!,
                      color: iconColor,
                      size: iconSize,
                    ),
                  ),
                Text(
                  title.data!,
                  style: defaultTitleStyle.merge(title.style),
                  textAlign: title.textAlign,
                  maxLines: title.maxLines,
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      subtitle!.data!,
                      textAlign: subtitle?.textAlign,
                      maxLines: subtitle?.maxLines,
                      style: defaultSubtitleStyle!.merge(subtitle!.style),
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
