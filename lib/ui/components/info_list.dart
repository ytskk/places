import 'dart:developer';

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
class InfoList extends StatefulWidget {
  /// Creates widget, displaying [icon], [title] and [subtitle].
  ///
  /// [title] must be not null.
  const InfoList({
    Key? key,
    required this.infoListData,
    this.animate = false,
  }) : super(key: key);

  final InfoListData infoListData;
  final bool animate;

  @override
  State<InfoList> createState() => _InfoListState();
}

class _InfoListState extends State<InfoList>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _iconScaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: longDuration,
    );

    _iconScaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: brandCurve,
      ),
    );

    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 250), () {
        _animationController.forward();
      });
    } else {
      _animationController.value = 1;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                if (widget.infoListData.iconName != null)
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: widget.infoListData.iconPaddingBottom),
                    child: ScaleTransition(
                      scale: _iconScaleAnimation,
                      child: IconBox(
                        icon: widget.infoListData.iconName!,
                        color: widget.infoListData.iconColor,
                        size: widget.infoListData.iconSize,
                      ),
                    ),
                  ),
                Text(
                  widget.infoListData.title.data!,
                  style: defaultTitleStyle
                      .copyWith(color: widget.infoListData.titleColor)
                      .merge(widget.infoListData.title.style),
                  textAlign: widget.infoListData.title.textAlign,
                  maxLines: widget.infoListData.title.maxLines,
                ),
                if (widget.infoListData.subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      widget.infoListData.subtitle!.data!,
                      textAlign: widget.infoListData.subtitle?.textAlign,
                      maxLines: widget.infoListData.subtitle?.maxLines,
                      style: defaultSubtitleStyle!
                          .merge(widget.infoListData.subtitle!.style),
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
