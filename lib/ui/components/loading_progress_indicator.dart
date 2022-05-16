import 'package:flutter/material.dart';

class LoadingProgressIndicator extends StatelessWidget {
  const LoadingProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(
          backgroundColor: theme.backgroundColor,
          color: theme.primaryColor,
          strokeWidth: 16,
        ),
      ),
    );
  }
}
