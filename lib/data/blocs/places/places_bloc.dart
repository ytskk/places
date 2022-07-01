import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/api/network_exception.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/models/places_filter_request_dto.dart';

part 'places_event.dart';

part 'places_state.dart';

class PlacesBloc extends Bloc<PlacesEvent, PlacesState> {
  final PlaceInteractor placesInteractor;

  PlacesBloc({
    required this.placesInteractor,
  }) : super(PlacesInitial()) {
    log('places bloc created');
    on<PlacesLoadInitial>(onPlacesLoadInitial);
    on<PlacesLoad>(onPlacesLoad);
  }

  onPlacesLoad(
    PlacesLoad event,
    Emitter<PlacesState> emit,
  ) async {
    emit(PlacesLoadInProgress());
    try {
      final places = await placesInteractor.getPlaces(
        filterOptions: event.filterOptions,
        radiusFrom: event.radiusFrom,
      );
      emit(PlacesLoadSuccess(places));
    } on NetworkException catch (e) {
      emit(PlacesLoadFailure(e));
    }
  }

  onPlacesLoadInitial(
    PlacesLoadInitial event,
    Emitter<PlacesState> emit,
  ) async {
    emit(PlacesLoadInProgress());
    try {
      final places = await placesInteractor.getPlaces(
        filterOptions: PlacesFilterRequestDto.defaultRequest(),
        radiusFrom: 0,
      );
      emit(PlacesLoadSuccess(places));
    } on NetworkException catch (e) {
      emit(PlacesLoadFailure(e));
    }
  }
}
