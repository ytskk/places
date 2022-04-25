// Model for Place.
class Place {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String type;
  final String description;

  Place({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.type,
    required this.description,
  });

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json['id'],
        lat: json['lat'],
        lng: json['lng'],
        name: json['name'],
        urls: List<String>.from(json['urls']),
        type: json['placeType'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
      'name': name,
      'urls': urls,
      'placeType': type,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Place#$id: $name';
  }
}

class PlaceDto extends Place {
  PlaceDto({
    required int id,
    required double lat,
    required double lng,
    required String name,
    required List<String> urls,
    required String type,
    required String description,
    this.distance = -1,
  }) : super(
          id: id,
          lat: lat,
          lng: lng,
          name: name,
          urls: urls,
          type: type,
          description: description,
        );

  /// Distance to the search point in meters.
  final double distance;

  @override
  factory PlaceDto.fromJson(Map<String, dynamic> json) => PlaceDto(
        id: json['id'],
        lat: json['lat'],
        lng: json['lng'],
        name: json['name'],
        urls: List<String>.from(json['urls']),
        type: json['placeType'],
        description: json['description'],
        distance: json['distance'],
      );

  @override
  String toString() {
    return 'PlaceDto#$id: $name (distance: $distance)';
  }
}
