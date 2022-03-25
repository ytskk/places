import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 16,
    );
  }
}

class HorizontalDividerInset extends StatelessWidget {
  const HorizontalDividerInset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 16,
      indent: 88,
    );
  }
}
