import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/models/sight.dart';

class VisitingPlaces extends ChangeNotifier {
  // definition
  final List<Sight> _wantToVisitPlaces = [
    mocks[0],
    mocks[2],
  ];
  final List<Sight> _visitedPlaces = [...mocks];

  // getters
  List<Sight> get wantToVisitPlaces => _wantToVisitPlaces;

  List<Sight> get visitedPlaces => _visitedPlaces;

  // setters
  void deleteWantToVisitPlaceById(Key id) {
    _wantToVisitPlaces.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void deleteVisitedPlaceById(Key id) {
    _visitedPlaces.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
