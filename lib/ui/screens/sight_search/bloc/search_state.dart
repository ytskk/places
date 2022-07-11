part of 'search_bloc.dart';

enum SearchStatus {
  empty,
  loading,
  success,
}

class SearchState extends Equatable {
  SearchState({
    this.query,
    this.history = const [],
    this.places = const [],
    required this.status,
  });

  final String? query;
  final List<SearchHistoryRecord> history;
  final List<PlaceDto> places;
  final SearchStatus status;

  SearchState copyWith({
    String? query,
    List<SearchHistoryRecord>? history,
    List<PlaceDto>? places,
    SearchStatus? status,
  }) {
    return SearchState(
      query: query ?? this.query,
      status: status ?? this.status,
      history: history ?? this.history,
      places: places ?? this.places,
    );
  }

  @override
  List<Object?> get props => [
        query,
        history,
        places,
        status,
      ];
}
