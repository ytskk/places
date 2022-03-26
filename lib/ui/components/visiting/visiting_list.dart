import 'package:flutter/material.dart';

class VisitingList<T> extends StatelessWidget {
  final List<T> content;
  final Widget Function(T) generator;

  const VisitingList({
    Key? key,
    required this.generator,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...content.map(generator).toList(),
      ],
    );
  }
}
