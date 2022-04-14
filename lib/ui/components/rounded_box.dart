import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';

/// A widget that wraps it's child using a rounded rectangle.
class RoundedBox extends StatelessWidget {
  /// Creates a rounded-rectangular clip.
  ///
  /// The [borderRadius] defaults to [smallBorderRadius].
  ///
  /// Uses [Clip.antiAlias].
  const RoundedBox({
    Key? key,
    required this.child,
    this.borderRadius = smallBorderRadius,
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
