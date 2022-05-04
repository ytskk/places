import 'package:flutter/cupertino.dart';

class Sight {
  /// Creates sight object.
  ///
  /// [name] must be not null.
  ///
  /// ```
  ///   Sight(name: 'New place')
  /// ```
  Sight({
    required this.name,
    this.lat = 0.0,
    this.lon = 0.0,
    this.url = '',
    this.images = const [],
    this.details = '',
    this.type = '',
  }) : id = UniqueKey();

  Key id;
  String name;
  double lat, lon;

  /// Link to primary sight image. To be deleted!
  String url;

  /// List of sight images.
  List<String> images;

  String details;
  String type;

  @override
  String toString() {
    return "${name}";
  }
}

class SightCategories {
  static const movie = PlaceCategory(name: 'Кинотеатр', engName: 'movie');
  static const restaurant =
      PlaceCategory(name: 'Ресторан', engName: 'restaurant');
  static const poi = PlaceCategory(name: 'Особое место', engName: 'poi');
  static const theater = PlaceCategory(name: 'Театр', engName: 'theatre');
  static const hotel = const PlaceCategory(name: 'Отель', engName: 'hotel');
  static const museum = PlaceCategory(name: 'Музей', engName: 'museum');
  static const cafe = PlaceCategory(name: 'Кафе', engName: 'cafe');
  static const park = PlaceCategory(name: 'Парк', engName: 'park');
}

class PlaceCategory {
  final String name;
  final String engName;

  const PlaceCategory({
    required this.name,
    required this.engName,
  });
}
