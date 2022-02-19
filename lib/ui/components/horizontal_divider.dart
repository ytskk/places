import 'package:flutter/material.dart';

Widget HorizontalDivider() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Divider(
      height: 0.8,
      color: Color.fromRGBO(124, 126, 146, 0.24),
    ),
  );
}
