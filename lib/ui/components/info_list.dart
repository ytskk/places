import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/ui/components/icon_box.dart';

class InfoListData {
  final String? iconName;
  final Color? iconColor;
  final double iconSize;
  final double iconPaddingBottom;
  final Text title;
  final Color? titleColor;
  final Text? subtitle;

  InfoListData({
    this.iconName,
    this.iconColor,
    this.iconSize = 64,
    this.iconPaddingBottom = 24,
    this.title = const Text('Info'),
    this.titleColor,
    this.subtitle,
  });
}

/// Widget displaying a message content
class InfoList extends StatelessWidget {
  /// Creates widget, displaying [icon], [title] and [subtitle].
  ///
  /// [title] must be not null.
  const InfoList({
    Key? key,
    required this.infoListData,
  }) : super(key: key);

  final InfoListData infoListData;

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
                if (infoListData.iconName != null)
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: infoListData.iconPaddingBottom),
                    child: IconBox(
                      icon: infoListData.iconName!,
                      color: infoListData.iconColor,
                      size: infoListData.iconSize,
                    ),
                  ),
                Text(
                  infoListData.title.data!,
                  style: defaultTitleStyle
                      .copyWith(color: infoListData.titleColor)
                      .merge(infoListData.title.style),
                  textAlign: infoListData.title.textAlign,
                  maxLines: infoListData.title.maxLines,
                ),
                if (infoListData.subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      infoListData.subtitle!.data!,
                      textAlign: infoListData.subtitle?.textAlign,
                      maxLines: infoListData.subtitle?.maxLines,
                      style: defaultSubtitleStyle!
                          .merge(infoListData.subtitle!.style),
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
