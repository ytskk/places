import 'package:flutter/material.dart';

class RowGroup extends StatelessWidget {
  final Widget child;
  final Text title;
  final Text titleAfter;
  final double paddingLeft;
  final double paddingTop;
  final double paddingBottom;

  const RowGroup({
    Key? key,
    required Widget this.child,
    Text this.title = const Text(""),
    Text this.titleAfter = const Text(""),
    double this.paddingLeft = 0,
    double this.paddingTop = 24,
    double this.paddingBottom = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
              if (title.data!.length > 0)
                Text(
                  title.data!,
                  style: textTheme.bodyText1!
                      .copyWith(
                        fontSize: 12,
                      )
                      .merge(title.style),
                ),
              if (titleAfter.data!.length > 0)
                Text(
                  titleAfter.data!,
                  style: textTheme.bodyText1!
                      .copyWith(
                        fontSize: 12,
                      )
                      .merge(titleAfter.style),
                ),
            ],
          ),
        ),
        child,
      ],
    );
  }
}
