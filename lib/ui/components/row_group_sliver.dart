import 'package:flutter/material.dart';

class FilterRowGroup extends StatelessWidget {
  final Widget child;
  final Text title;
  final Text titleAfter;

  const FilterRowGroup({
    Key? key,
    required Widget this.child,
    required Text this.title,
    Text this.titleAfter = const Text(""),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            children: [
              BuildFilterCategoryTitle(
                title: title,
                titleAfter: titleAfter,
              ),
              child,
            ],
          ),
        ],
      ),
    );
  }
}

class BuildFilterCategoryTitle extends StatelessWidget {
  final Text title;
  final Text titleAfter;

  const BuildFilterCategoryTitle({
    Key? key,
    required Text this.title,
    Text this.titleAfter = const Text(""),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleTextTheme = Theme.of(context).textTheme.bodyText1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.data!,
            style: titleTextTheme!
                .copyWith(
                  fontSize: 12,
                  color: titleTextTheme.color!.withOpacity(0.56),
                )
                .merge(title.style),
          ),
          if (titleAfter.data!.length > 0)
            Text(
              titleAfter.data!,
              style: titleTextTheme
                  .copyWith(
                    fontSize: 12,
                  )
                  .merge(titleAfter.style),
            ),
        ],
      ),
    );
  }
}
