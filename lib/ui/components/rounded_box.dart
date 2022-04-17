import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';

/// A widget that wraps it's child using a rounded rectangle.
class RoundedBox extends StatelessWidget {
  /// Creates a rounded-rectangular box.
  ///
  /// The [borderRadius] defaults to [smallBorderRadius].
  ///
  /// Uses [Clip.antiAlias].
  const RoundedBox({
    Key? key,
    required this.child,
    this.borderRadius = smallBorderRadius,
    this.color,
  }) : super(key: key);

  final Widget child;
  final double borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
        ),
        child: child,
      ),
    );
  }
}
