import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  const RoundedBox({
    Key? key,
    required this.child,
    this.borderRadius = 12,
  }) : super(key: key);

  final Widget child;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(borderRadius),
      child: child,
    );
  }
}
