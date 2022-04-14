import 'package:flutter/material.dart';

/// Wrapping text and provided content.
class RowGroup extends StatelessWidget {
  /// Creates [Column] based widget.
  ///
  /// [title] and [titleAfter] may be null, in that case only [child] will rendered.
  const RowGroup({
    Key? key,
    required this.child,
    this.title,
    this.titleAfter,
    this.paddingLeft = 0,
    this.paddingTop = 24,
    this.paddingBottom = 8,
  }) : super(key: key);

  /// Any widget that can be placed in [Column].
  final Widget child;

  /// Have base style, that is merging with provided [title] style.
  final Text? title;

  /// Have base style, that is merging with provided [titleAfter] style.
  final Text? titleAfter;

  /// Padding for header ([title] + [titleAfter]) content.
  final double paddingLeft;

  /// Padding for header ([title] + [titleAfter]) content.
  final double paddingTop;

  /// Padding for header ([title] + [titleAfter]) content.
  final double paddingBottom;

  @override
  Widget build(BuildContext context) {
    final defaultTitleTextStyle =
        Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 12,
            );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: paddingTop,
            bottom: paddingBottom,
            left: paddingLeft,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (title != null)
                Text(
                  title!.data!,
                  style: defaultTitleTextStyle.merge(title!.style),
                ),
              if (titleAfter != null)
                Text(
                  titleAfter!.data!,
                  style: defaultTitleTextStyle.merge(titleAfter!.style),
                ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
