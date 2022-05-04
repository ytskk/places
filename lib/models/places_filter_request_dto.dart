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
  }) :

        /// assert if one of them is specified, then the other two become mandatory
        assert((radius != null || lat != null || lng != null) &&
            (radius != null && lat != null && lng != null));

  // to json
  Map<String, dynamic> toJson() => {
        'radius': radius,
        'lat': lat,
        'lng': lng,
        'typeFilter': typeFilter,
        'nameFilter': nameFilter,
      };
}
