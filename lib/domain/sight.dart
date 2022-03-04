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
  static const shoppingCentre = "Торговый центр";
  static const sightseeing = "Достопримечательность";
  static const historicalBuilding = "Памятник, мемориал";
  static const coffeeShop = "Кофейня";
}
