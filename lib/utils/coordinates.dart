import 'dart:math';

import 'package:places/models/coordinates.dart';

bool isPointInBetween(
  Coordinates checkPoint,
  Coordinates centerPoint,
  double from,
  double to,
) {
  final double ky = 40000 / 360;
  final double kx = cos(pi * centerPoint.lat / 180.0) * ky;
  final double dx = (centerPoint.lon - checkPoint.lon).abs() * kx;
  final double dy = (centerPoint.lat - checkPoint.lat).abs() * ky;

  final distance = sqrt(dx * dx + dy * dy) * 1000;

  return distance >= from && distance <= to;
}
