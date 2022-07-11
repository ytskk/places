part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class SearchChanged extends SearchEvent {
  const SearchChanged({
    required this.query,
  });

  final String? query;

  @override
  List<Object?> get props => [query];
}

class SearchCleared extends SearchEvent {
  const SearchCleared();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class SearchHistoryLoad extends SearchEvent {
  const SearchHistoryLoad();

  @override
  List<Object?> get props => [];
}

class SearchHistoryAdd extends SearchEvent {
  const SearchHistoryAdd({
    required this.query,
  });

  final String query;

  @override
  List<Object?> get props => [query];
}

class SearchHistoryRemove extends SearchEvent {
  const SearchHistoryRemove({
    required this.historyRecord,
  });

  final SearchHistoryRecord historyRecord;

  @override
  List<Object?> get props => [historyRecord];
}

class SearchHistoryClear extends SearchEvent {
  const SearchHistoryClear();

  @override
  List<Object?> get props => [];
}
