import 'package:equatable/equatable.dart';
import 'package:places/models/sight.dart';

class Place extends Equatable {
  final int? id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final PlaceCategory type;
  final String? description;
  bool isFavorite;
  bool isVisited;
  DateTime? plannedAt;
  DateTime? visitedAt;

  Place({
    this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.type,
    required this.description,
    bool? isFavorite,
    bool? isVisited,
    DateTime? plannedAt,
    DateTime? visitedAt,
  })  : this.isFavorite = isFavorite ?? false,
        this.isVisited = isVisited ?? false,
        this.plannedAt = plannedAt,
        this.visitedAt = visitedAt;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
        id: json['id'],
        lat: json['lat'],
        lng: json['lng'],
        name: json['name'],
        urls: List<String>.from(json['urls']),
        type: PlaceCategory.fromJson(json['placeType']),
        description: json['description'],
      );

  factory Place.fromDto(PlaceDto placeDto) => Place(
        id: placeDto.id,
        lat: placeDto.lat,
        lng: placeDto.lng,
        name: placeDto.name,
        urls: List<String>.from(placeDto.urls),
        type: placeDto.type,
        description: placeDto.description,
      );

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
      'name': name,
      'urls': urls,
      'placeType': type.engName,
      'description': description,
    };
  }

  // copy with
  Place copyWith({
    bool? isFavorite,
    bool? isVisited,
    DateTime? plannedAt,
    DateTime? visitedAt,
  }) {
    return Place(
      id: this.id,
      lat: this.lat,
      lng: this.lng,
      name: this.name,
      urls: this.urls,
      type: this.type,
      description: this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isVisited: isVisited ?? this.isVisited,
      plannedAt: plannedAt ?? this.plannedAt,
      visitedAt: visitedAt ?? this.visitedAt,
    );
  }

  @override
  String toString() {
    return 'Place#$id: $name ($type) ($isFavorite, $plannedAt, $isVisited)';
  }

  @override
  bool operator ==(Object other) =>
      other is Place &&
      this.id == other.id &&
      this.lat == other.lat &&
      this.lng == other.lng &&
      this.name == other.name &&
      this.urls == other.urls &&
      this.type == other.type &&
      this.description == other.description &&
      this.isFavorite == other.isFavorite &&
      this.isVisited == other.isVisited &&
      this.plannedAt == other.plannedAt &&
      this.visitedAt == other.visitedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      name.hashCode ^
      urls.hashCode ^
      type.hashCode ^
      description.hashCode ^
      isFavorite.hashCode ^
      isVisited.hashCode ^
      plannedAt.hashCode ^
      visitedAt.hashCode;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// String localizeType(String type) {
//   if (type == SightCategories.museum.engName) {
//     return SightCategories.museum.name;
//   }
//   if (type == SightCategories.park.engName) {
//     return SightCategories.park.name;
//   }
//   if (type == SightCategories.restaurant.engName) {
//     return SightCategories.restaurant.name;
//   }
//   if (type == SightCategories.theater.engName) {
//     return SightCategories.theater.name;
//   }
//   if (type == SightCategories.hotel.engName) {
//     return SightCategories.hotel.name;
//   }
//   if (type == SightCategories.poi.engName) {
//     return SightCategories.poi.name;
//   }
//   if (type == SightCategories.movie.engName) {
//     return SightCategories.movie.name;
//   }
//   if (type == SightCategories.park.engName) {
//     return SightCategories.park.name;
//   }
//   if (type == 'other') {
//     return 'Другое';
//   }
//
//   return type;
// }

class PlaceDto extends Place {
  PlaceDto({
    int? id,
    required double lat,
    required double lng,
    required String name,
    required List<String> urls,
    required PlaceCategory type,
    required String description,
    this.distance = -1,
  }) : super(
          id: id ?? DateTime.now().millisecondsSinceEpoch,
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
        type: PlaceCategory.fromJson(json['placeType']),
        description: json['description'],
        distance: json['distance'],
      );

  @override
  String toString() {
    return 'PlaceDto#$id: $name ($type) ($distance: {$lat; $lng}) ($description)';
  }
}
