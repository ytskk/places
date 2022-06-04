import 'package:places/data/model/place_model.dart';
import 'package:places/models/places_filter_request_dto.dart';

abstract class SearchAction {}

class LoadSearchAction extends SearchAction {
  final PlacesFilterRequestDto filter;

  LoadSearchAction(this.filter);
}

class ResultSearchAction extends SearchAction {
  final List<PlaceDto> places;

  ResultSearchAction(this.places);
}
