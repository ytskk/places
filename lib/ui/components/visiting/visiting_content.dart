import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/empty_list.dart';
import 'package:places/ui/components/visiting/visiting_list.dart';

class VisitingContent<T> extends StatelessWidget {
  final List<T> content;
  final Widget Function(T) generator;

  const VisitingContent({
    Key? key,
    required this.content,
    required this.generator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return content.isNotEmpty
        ? SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: VisitingList(content: content, generator: generator),
          )
        : EmptyList(
            iconName: AppIcons.card,
            title: AppStrings.visitingEmpty,
            subtitle: AppStrings.visitingWantToVisitEmpty,
          );
  }
}
