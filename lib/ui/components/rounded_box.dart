import 'package:flutter/material.dart';

/// A widget that wraps it's child using a rounded rectangle.
class RoundedBox extends StatelessWidget {
  /// Creates a rounded-rectangular clip.
  ///
  /// The [borderRadius] defaults to 12.
  ///
  /// Uses [Clip.antiAlias].
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
