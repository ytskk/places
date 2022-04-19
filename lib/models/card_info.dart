import 'package:flutter/material.dart';

/// Contains displayable card info.
class CardInfo {
  final String title;
  final String? subtitle;
  final Color? subtitleColor;
  final String? text;

  const CardInfo({
    required String this.title,
    String? this.text,
    String? this.subtitle,
    Color? this.subtitleColor,
  });
}
