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
  static const restaurant =
      const PlaceCategory(name: 'Ресторан', engName: 'restaurant');
  static const cafe = const PlaceCategory(name: 'Кафе', engName: 'cafe');
  static const movie = const PlaceCategory(name: 'Кинотеатр', engName: 'movie');
  static const park = const PlaceCategory(name: 'Парк', engName: 'park');
  static const museum = const PlaceCategory(name: 'Музей', engName: 'museum');
  static const temple = const PlaceCategory(name: 'Храм', engName: 'temple');
  static const hotel = const PlaceCategory(name: 'Отель', engName: 'hotel');
  static const theater = const PlaceCategory(name: 'Театр', engName: 'theatre');
  static const monument =
      const PlaceCategory(name: 'Монумент', engName: 'monument');
  static const other = const PlaceCategory(name: 'Другое', engName: 'other');

  static const all = [
    restaurant,
    cafe,
    movie,
    park,
    museum,
    temple,
    hotel,
    theater,
    monument,
    other,
  ];

  static final allEng = [
    restaurant.engName,
    cafe.engName,
    movie.engName,
    park.engName,
    museum.engName,
    temple.engName,
    hotel.engName,
    theater.engName,
    monument.engName,
    other.engName,
  ];
}

class PlaceCategory {
  final String name;
  final String engName;

  const PlaceCategory({
    required this.name,
    required this.engName,
  });

  factory PlaceCategory.fromJson(String engName) {
    return localizeCategory(engName);
  }

  static PlaceCategory localizeCategory(String engName) {
    switch (engName) {
      case 'restaurant':
        return SightCategories.restaurant;
      case 'cafe':
        return SightCategories.cafe;
      case 'movie':
        return SightCategories.movie;
      case 'park':
        return SightCategories.park;
      case 'museum':
        return SightCategories.museum;
      case 'temple':
        return SightCategories.temple;
      case 'hotel':
        return SightCategories.hotel;
      case 'theatre':
        return SightCategories.theater;
      case 'monument':
        return SightCategories.monument;
      case 'other':
      default:
        return SightCategories.other;
    }
  }

  @override
  String toString() {
    return 'PlaceCategory{name: $name, engName: $engName}';
  }
}
