import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';

/// Thin horizontal line.
class HorizontalDivider extends StatelessWidget {
  /// Creates a divider with fixed [height] of 16lp.
  const HorizontalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: mediumSpacing,
    );
  }
}

/// Thin horizontal line.
class HorizontalDividerInset extends StatelessWidget {
  /// Creates a divider with fixed [height] of 16lp and indentation of 88lx
  /// (to achieve pretty look for [ListTile]).
  const HorizontalDividerInset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 16,
      indent: 88,
    );
  }
}
