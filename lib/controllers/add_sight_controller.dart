import 'package:flutter/cupertino.dart';

class AddSight extends ChangeNotifier {
  String _sightCategory = "";
  String _sightName = "";
  double _sightCoordinatesLat = 0.0;
  double _sightCoordinatesLon = 0.0;
  String _sightDescription = "";

  String get category => _sightCategory;

  void setCategory(String value) {
    _sightCategory = value;
    notifyListeners();
  }

  String get name => _sightName;

  void setName(String name) {
    _sightName = name;
    notifyListeners();
  }

  double get coordinatesLat => _sightCoordinatesLat;

  void setCoordinatesLat(double latitude) {
    _sightCoordinatesLat = latitude;
    notifyListeners();
  }

  double get coordinatesLon => _sightCoordinatesLon;

  void setCoordinatesLon(double longitude) {
    _sightCoordinatesLon = longitude;
    notifyListeners();
  }

  String get description => _sightDescription;

  void setDescription(String description) {
    _sightDescription = description;
    notifyListeners();
  }

  List validateFields() {
    return [
      _sightName,
      _sightCategory,
      _sightCoordinatesLat,
      _sightCoordinatesLon,
      _sightDescription,
    ];
  }
}
