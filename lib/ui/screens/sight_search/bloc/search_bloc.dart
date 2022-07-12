import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/repository/local_repository.dart';
import 'package:places/models/places_filter_request_dto.dart';
import 'package:places/models/search_history_record.dart';
import 'package:places/ui/screens/add_sight/bloc/add_sight.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(
    this._placeInteractor,
    this._localRepository,
  ) : super(
          SearchState(
            status: SearchStatus.empty,
          ),
        ) {
    on<SearchChanged>(
      _onSearchChanged,
      transformer: debounce(
        Duration(milliseconds: 300),
      ),
    );
    on<SearchCleared>(_onSearchCleared);
    on<SearchHistoryLoad>(_onHistoryLoad);
    on<SearchHistoryAdd>(_onHistoryAdd);
    on<SearchHistoryRemove>(_onHistoryRemove);
    on<SearchHistoryClear>(_onHistoryClear);
  }

  final PlaceInteractor _placeInteractor;
  final LocalRepository _localRepository;

  void _onSearchChanged(SearchChanged event, Emitter<SearchState> emit) async {
    if (event.query == null || event.query!.trim().isEmpty) {
      emit(
        state.copyWith(
          query: event.query,
          status: SearchStatus.empty,
          places: [],
        ),
      );
      log('empty query');

      return;
    }

    emit(
      state.copyWith(
        status: SearchStatus.loading,
        query: event.query,
      ),
    );

    final PlacesFilterRequestDto filterOptions =
        PlacesFilterRequestDto.defaultRequest(
      nameFilter: event.query,
    );

    final places = await _placeInteractor.searchPlace(
      filterOptions: filterOptions,
    );

    emit(
      state.copyWith(
        places: places,
        status: SearchStatus.success,
      ),
    );
  }

  void _onHistoryAdd(SearchHistoryAdd event, Emitter<SearchState> emit) {
    if (event.query.trim().isEmpty) {
      return;
    }
    log('adding to history ${event.query}');

    _localRepository.addToSearchHistory(event.query.trim());
    emit(state.copyWith(history: _localRepository.searchHistory));
  }

  void _onHistoryRemove(
      SearchHistoryRemove event, Emitter<SearchState> emit) async {
    await _localRepository.removeFromSearchHistory(event.historyRecord);
    final List<SearchHistoryRecord> newHistory =
        await _localRepository.searchHistory;

    emit(
      state.copyWith(
        history: newHistory,
      ),
    );
  }

  void _onHistoryClear(SearchHistoryClear event, Emitter<SearchState> emit) {
    _localRepository.clearSearchHistory();
    emit(
      state.copyWith(
        history: [],
      ),
    );
    log('cleared history');
  }

  void _onHistoryLoad(
    SearchHistoryLoad event,
    Emitter<SearchState> emit,
  ) async {
    final List<SearchHistoryRecord> history =
        await _localRepository.searchHistory;
    emit(
      state.copyWith(
        history: history,
      ),
    );
  }

  void _onSearchCleared(SearchCleared event, Emitter<SearchState> emit) {
    emit(
      state.copyWith(
        query: null,
        status: SearchStatus.empty,
      ),
    );
  }
}
