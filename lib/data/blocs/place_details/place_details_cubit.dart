import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';

part 'place_details_state.dart';

class PlaceDetailsCubit extends Cubit<PlaceDetailsState> {
  final PlaceInteractor placeInteractor;

  PlaceDetailsCubit({
    required this.placeInteractor,
  }) : super(PlaceDetailsInitial()) {
    log('PlaceDetailsCubit');
  }

  Future<void> loadPlaceDetails(String placeId) async {
    emit(PlaceDetailsLoadInProgress());
    try {
      final placeDetails = await placeInteractor.getPlaceDetails(id: placeId);
      emit(PlaceDetailsLoadSuccess(placeDetails));
    } on DioError catch (e) {
      emit(PlaceDetailsLoadFailure(placeInteractor.handleError(e)));
    }
  }
}
