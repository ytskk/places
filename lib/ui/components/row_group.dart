import 'package:flutter/material.dart';

class RowGroup extends StatelessWidget {
  final Widget child;
  final Text title;
  final Text titleAfter;

  const RowGroup({
    Key? key,
    required Widget this.child,
    Text this.title = const Text(""),
    Text this.titleAfter = const Text(""),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (title.data!.length > 0)
                Text(
                  title.data!.toUpperCase(),
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
          child,
        ],
      ),
    );
  }
}
