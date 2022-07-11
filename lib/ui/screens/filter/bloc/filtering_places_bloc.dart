import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/models/places_filter_request_dto.dart';
import 'package:places/ui/screens/add_sight/bloc/add_sight_bloc.dart';

part 'filtering_places_event.dart';

part 'filtering_places_state.dart';

class FilteringPlacesBloc
    extends Bloc<FilteringPlacesEvent, FilteringPlacesState> {
  FilteringPlacesBloc(this.placeInteractor) : super(FilteringPlacesInitial()) {
    on<FilteringPlacesLoad>(
      _onFilteringPlacesLoad,
      transformer: debounce(
        const Duration(milliseconds: 100),
      ),
    );
  }

  final PlaceInteractor placeInteractor;

  void _onFilteringPlacesLoad(
      FilteringPlacesLoad event, Emitter<FilteringPlacesState> emit) async {
    try {
      emit(FilteringPlacesLoadInProgress());
      final places = await placeInteractor.getPlaces(
        radiusFrom: event.radiusFrom,
        filterOptions: PlacesFilterRequestDto(
          radius: event.radiusTo,
          typeFilter: event.selectedOptions,
          lat: 12,
          lng: 17,
        ),
      );

      emit(FilteringPlacesLoadSuccess(places));
    } catch (e) {
      log('Error: $e');
      // emit(FilteringPlacesLoadFailure());
    }
  }
}
