import 'package:places/models/sight.dart';

class PlacesFilterRequestDto {
  final double? radius;
  final double? lat;
  final double? lng;
  final List<String>? typeFilter;
  final String? nameFilter;

  const PlacesFilterRequestDto({
    this.radius,
    this.lat,
    this.lng,
    this.typeFilter,
    this.nameFilter,
  });

  static const double _defaultRadius = 1000000.0;
  static final List<String> _allCategories = SightCategories.allEng;

  static defaultRequest({
    double? radius,
    double? lat,
    double? lng,
    String? nameFilter,
  }) =>
      PlacesFilterRequestDto(
        radius: radius ?? _defaultRadius,
        lat: lat ?? 12.0,
        lng: lng ?? 17.0,
        typeFilter: _allCategories,
        nameFilter: nameFilter ?? '',
      );

  PlacesFilterRequestDto copyWith({
    double? radius,
    double? lat,
    double? lng,
    List<String>? typeFilter,
    String? nameFilter,
  }) =>
      PlacesFilterRequestDto(
        radius: radius ?? this.radius,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        typeFilter: typeFilter ?? this.typeFilter,
        nameFilter: nameFilter ?? this.nameFilter,
      );

  Map<String, dynamic> toJson() => {
        'radius': radius,
        'lat': lat,
        'lng': lng,
        'typeFilter': typeFilter,
        'nameFilter': nameFilter,
      };
}
