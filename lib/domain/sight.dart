// Sight Details model.
class Sight {
  String name;
  double lat, lon;
  String url;
  String details;
  String type;

  /// Default sight constructor.
  ///
  /// name is required
  ///
  /// Example
  /// ```dart
  ///   Sight(name: 'New place')
  /// ```
  Sight({
    required this.name,
    this.lat = 0.0,
    this.lon = 0.0,
    this.url = '',
    this.details = '',
    this.type = '',
  });

  @override
  String toString() {
    return "${name}";
  }
}

class SightCategories {
  static const movie = "Кинотеатр";
  static const restaurant = "Ресторан";
  static const poi = "Особое место";
  static const theatre = "Театр";
  static const hotel = "Отель";
  static const museum = "Музей";
  static const cafe = "Кафе";
  static const park = "Парк";

  static List<String> getValues() {
    return [];
  }
}
