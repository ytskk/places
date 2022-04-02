import 'package:flutter/material.dart';
import 'package:places/ui/components/empty_list.dart';

// TODO: merge visited and want to visit.
class VisitingListContent<T> extends StatefulWidget {
  const VisitingListContent({
    Key? key,
    required this.liContent,
    required this.liContentChildren,
    required this.emptyListTitle,
    required this.emptyListSubtitle,
    required this.emptyListIconName,
  }) : super(key: key);

  final List<T> liContent;
  final List<Widget> liContentChildren;
  final String emptyListTitle;
  final String emptyListSubtitle;
  final String emptyListIconName;

  @override
  State<VisitingListContent<T>> createState() => _VisitingListContentState<T>();
}

class _VisitingListContentState<T> extends State<VisitingListContent<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.liContent.isNotEmpty
        ? ReorderableListView(
            padding: const EdgeInsets.all(16.0),
            children: widget.liContentChildren,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final T item = widget.liContent.removeAt(oldIndex);
                widget.liContent.insert(newIndex, item);
              });
            },
          )
        : EmptyList(
            iconName: widget.emptyListIconName,
            title: widget.emptyListTitle,
            subtitle: widget.emptyListSubtitle,
          );
  }
}
