// import 'dart:async';
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:places/data/api/network_exception.dart';
// import 'package:places/data/interactor/place_interactor.dart';
// import 'package:places/data/model/place_model.dart';
// import 'package:places/mocks.dart';
// import 'package:places/models/filter_option.dart';
// import 'package:provider/provider.dart';
//
// class Filter extends ChangeNotifier {
//   List<FilterOption> _filterOptions = filterCategories
//       .map((category) => FilterOption(category: category))
//       .toList();
//
//   final List<Place> filteredPlaces = [];
//   final List<Place> foundedFilteredPlaces = [];
//
//   final StreamController<List<Place>> _filteredPlacesController =
//       StreamController.broadcast();
//
//   Stream<List<Place>> get filteredPlacesStream =>
//       _filteredPlacesController.stream;
//
//   void disposeStream() {
//     _filteredPlacesController.close();
//   }
//
//   Future<List<Place>> parseFilteredPlaces(BuildContext context) async {
//     final List<Place> response =
//         await context.read<PlaceInteractor>().getPlaces(
//               radiusFrom: _rangeValues.start,
//               radiusTo: _rangeValues.end,
//               types: selectedCategories,
//             );
//
//     log('${response.take(3)}', name: 'filter controller - parseFilteredPlaces');
//
//     return response;
//   }
//
//   Future<void> getFilteredPlaces(BuildContext context) async {
//     try {
//       final response = await parseFilteredPlaces(context);
//       _filteredPlacesController.sink.add(response);
//     } on NetworkException catch (e) {
//       _filteredPlacesController.sink.addError(e);
//     }
//   }
//
//   final double _rangeValueStart = 0.0;
//   final double _rangeValueEnd = 30000.0;
//   RangeValues _rangeValues = RangeValues(0.0, 30000.0);
//
//   RangeValues get rangeValues => _rangeValues;
//
//   double get initialRangeValueStart => _rangeValueStart;
//
//   double get initialRangeValueEnd => _rangeValueEnd;
//
//   void setRangeValues(RangeValues values) {
//     _rangeValues = values;
//     notifyListeners();
//   }
//
//   List<FilterOption> get filterOptions => _filterOptions;
//
//   List<FilterOption> get selectedOptions =>
//       _filterOptions.where((option) => option.isSelected).toList();
//
//   List<String> get selectedCategories =>
//       selectedOptions.map((FilterOption category) => category.engName).toList();
//
//   void clearFilterOptions() {
//     _filterOptions.forEach((category) {
//       category.setSelected(true);
//     });
//     log("Selected options: ${selectedOptions}");
//     _rangeValues = RangeValues(_rangeValueStart, _rangeValueEnd);
//
//     notifyListeners();
//   }
//
//   void setFoundedFilteredPlaces(List<Place> foundedFilteredPlaces) {
//     this.foundedFilteredPlaces
//       ..clear()
//       ..addAll(foundedFilteredPlaces);
//
//     notifyListeners();
//   }
//
//   void setFilteredPlaces(List<Place> filteredPlaces) {
//     this.filteredPlaces
//       ..clear()
//       ..addAll(filteredPlaces);
//
//     log('setFilteredPlaces: ${this.filteredPlaces.take(3)}',
//         name: 'setFilteredPlaces - filteredPlaces');
//
//     notifyListeners();
//   }
//
//   void toggleCategory(FilterOption category) {
//     category.setSelected(!category.isSelected);
//     log("Selected options: ${selectedOptions}");
//
//     notifyListeners();
//   }
// }
