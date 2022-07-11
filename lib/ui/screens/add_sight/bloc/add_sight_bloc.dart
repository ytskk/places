import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/screens/add_sight/models/models.dart';
import 'package:rxdart/rxdart.dart';

part 'add_sight_event.dart';
part 'add_sight_state.dart';

EventTransformer<MyEvent> debounce<MyEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class AddSightBloc extends Bloc<AddSightEvent, AddSightState> {
  AddSightBloc(this._placeInteractor)
      : super(
          AddSightState(
            formKey: GlobalKey<FormState>(),
          ),
        ) {
    on<AddSightCategoryChanged>(_onCategoryChanged);
    on<AddSightNameChanged>(_onNameChanged);
    on<AddSightCoordinateLatChanged>(_onCoordinateLatChanged);
    on<AddSightCoordinateLngChanged>(_onCoordinateLngChanged);
    on<AddSightDescriptionChanged>(_onDescriptionChanged);
    on<AddSightSubmitted>(_onSubmitted,
        transformer: debounce(const Duration(milliseconds: 500)));
  }

  final PlaceInteractor _placeInteractor;

  void _onCategoryChanged(
      AddSightCategoryChanged event, Emitter<AddSightState> emit) {
    final category = PlaceCategoryModel.dirty(event.placeCategory);
    emit(
      state.copyWith(
        placeCategory: category,
        status: Formz.validate(
          [
            state.placeName,
            category,
            state.placeCoordinateLat,
            state.placeCoordinateLng,
            state.placeDescription,
          ],
        ),
      ),
    );
  }

  void _onNameChanged(AddSightNameChanged event, Emitter<AddSightState> emit) {
    final name = PlaceNameModel.dirty(event.placeName);
    emit(
      state.copyWith(
        placeName: name,
        status: Formz.validate(
          [
            name,
            state.placeCategory,
            state.placeCoordinateLat,
            state.placeCoordinateLng,
            state.placeDescription,
          ],
        ),
      ),
    );
  }

  void _onCoordinateLatChanged(
      AddSightCoordinateLatChanged event, Emitter<AddSightState> emit) {
    final coordinateLat = PlaceCoordinatesModel.dirty(event.placeCoordinateLat);
    emit(
      state.copyWith(
        placeCoordinateLat: coordinateLat,
        status: Formz.validate(
          [
            state.placeName,
            state.placeCategory,
            coordinateLat,
            state.placeCoordinateLng,
            state.placeDescription,
          ],
        ),
      ),
    );
  }

  void _onCoordinateLngChanged(
      AddSightCoordinateLngChanged event, Emitter<AddSightState> emit) {
    final coordinateLng = PlaceCoordinatesModel.dirty(event.placeCoordinateLng);
    emit(
      state.copyWith(
        placeCoordinateLng: coordinateLng,
        status: Formz.validate(
          [
            state.placeName,
            state.placeCategory,
            state.placeCoordinateLat,
            coordinateLng,
            state.placeDescription,
          ],
        ),
      ),
    );
  }

  void _onDescriptionChanged(
      AddSightDescriptionChanged event, Emitter<AddSightState> emit) {
    final description = PlaceDescriptionModel.dirty(event.placeDescription);
    emit(
      state.copyWith(
        placeDescription: description,
        status: Formz.validate(
          [
            state.placeName,
            state.placeCategory,
            state.placeCoordinateLat,
            state.placeCoordinateLng,
            description,
          ],
        ),
      ),
    );
  }

  void _onSubmitted(
      AddSightSubmitted event, Emitter<AddSightState> emit) async {
    if (state.status.isValidated) {
      try {
        emit(
          state.copyWith(
            status: FormzStatus.submissionInProgress,
          ),
        );
        final List<String> randomPhotos = [
          'https://picsum.photos/1000/800?random=1',
          'https://picsum.photos/1000/800?random=2',
          'https://picsum.photos/1000/800?random=3',
          'https://picsum.photos/1000/800?random=4',
        ];
        final Place newPlace = Place(
          name: state.placeName.value,
          type: state.placeCategory.value!,
          lat: double.parse(state.placeCoordinateLat.value),
          lng: double.parse(state.placeCoordinateLng.value),
          description: state.placeDescription.value,
          urls: randomPhotos,
        );
        // TODO: make description required
        final response = await _placeInteractor.addPlace(place: newPlace);
        emit(
          state.copyWith(
            status: FormzStatus.submissionSuccess,
            placeId: response.data['id'].toString(),
          ),
        );
      } catch (e) {
        log('Error creating a new place: ${e}',
            name: 'AddSightBloc::_onSubmitted');
        emit(
          state.copyWith(
            status: FormzStatus.submissionFailure,
            error: e.toString(),
          ),
        );
      }
    }
  }
}
