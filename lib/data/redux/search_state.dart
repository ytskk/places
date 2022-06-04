import 'package:places/data/model/place_model.dart';

abstract class SearchState {}

class InitialSearchState extends SearchState {}

class LoadingSearchState extends SearchState {}

class ResultSearchState extends SearchState {
  final List<PlaceDto> places;

  ResultSearchState(this.places);
}
