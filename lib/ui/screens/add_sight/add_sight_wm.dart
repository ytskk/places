import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/data/api/network_exception.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/models/sight.dart';
import 'package:places/models/validation_model.dart';
import 'package:relation/relation.dart';

class AddSightWidgetModel extends WidgetModel {
  AddSightWidgetModel(
      WidgetModelDependencies baseDependencies, this._placeInteractor)
      : super(baseDependencies);

  final PlaceInteractor _placeInteractor;

  @override
  onBind() {
    super.onBind();
    placeDescriptionFocusNode = FocusNode();
    log('actions bounded', name: 'AddSightWidgetModel');

    subscribe(placeCategoryAction.stream, _onSelectCategory);
    subscribe(placeNameAction.stream, _onChangeName);
    subscribe(placeCoordinatesLatAction.stream, _onChangeCoordinatesLat);
    subscribe(placeCoordinatesLonAction.stream, _onChangeCoordinatesLon);
    subscribe(placeDescriptionAction.stream, _onChangeDescription);
    subscribe(submitForm.stream, _onSubmitForm);
  }

  @override
  dispose() {
    placeDescriptionFocusNode.dispose();
    super.dispose();
  }

  // definitions
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final FocusNode placeDescriptionFocusNode;

  // states
  final StreamedState<ValidationModel<PlaceCategory>> placeCategoryState =
      StreamedState(ValidationModel(null, null));
  final StreamedState<ValidationModel<String>> placeNameState =
      StreamedState(ValidationModel(null, null));
  final StreamedState<ValidationModel<String>> placeCoordinatesLatState =
      StreamedState(
    ValidationModel(null, null),
  );
  final StreamedState<ValidationModel<String>> placeCoordinatesLonState =
      StreamedState(
    ValidationModel(null, null),
  );
  final StreamedState<ValidationModel<String>> placeDescriptionState =
      StreamedState(
    ValidationModel(null, null),
  );
  final StreamedState<bool> createButtonState = StreamedState(false);

  // actions
  final StreamedAction<PlaceCategory?> placeCategoryAction = StreamedAction();
  final TextEditingAction placeNameAction = TextEditingAction();
  final TextEditingAction placeCoordinatesLatAction = TextEditingAction();
  final TextEditingAction placeCoordinatesLonAction = TextEditingAction();
  final TextEditingAction placeDescriptionAction = TextEditingAction();
  final StreamedAction submitForm = StreamedAction();

  // getters
  GlobalKey<FormState> get formKey => _formKey;

  // setters

  // methods
  // validations
  ValidationModel<PlaceCategory> validateCategory(PlaceCategory? value) {
    ValidationModel<PlaceCategory> _placeCategory =
        value != null && isValidCategory(value.name)
            ? ValidationModel(value, null)
            : ValidationModel(null, FieldsErrors.invalidCategory);
    submitForm(_placeCategory);

    return _placeCategory;
  }

  bool isValidCategory(String value) {
    return value.isNotEmpty;
  }

  ValidationModel<String> validateName(String? value) {
    ValidationModel<String> _placeName = value != null && isValidName(value)
        ? ValidationModel(value, null)
        : ValidationModel(null, FieldsErrors.invalidName);
    submitForm(_placeName);

    return _placeName;
  }

  bool isValidName(String value) {
    return value.trim().length >= 3;
  }

  ValidationModel<String> validateCoordinatesLat(String? value) {
    final ValidationModel<String> _placeCoordinatesLat =
        value != null && isValidCoordinates(value)
            ? ValidationModel(value, null)
            : ValidationModel(null, FieldsErrors.invalidCoordinates);
    submitForm(_placeCoordinatesLat);

    return _placeCoordinatesLat;
  }

  ValidationModel<String> validateCoordinatesLon(String? value) {
    final ValidationModel<String> _placeCoordinatesLon =
        value != null && isValidCoordinates(value)
            ? ValidationModel(value, null)
            : ValidationModel(null, FieldsErrors.invalidCoordinates);
    submitForm(_placeCoordinatesLon);

    return _placeCoordinatesLon;
  }

  bool isValidCoordinates(String value) {
    return value.isNotEmpty && FieldsPatterns.doublePattern.hasMatch(value);
  }

  ValidationModel<String> validateDescription(String? value) {
    ValidationModel<String> _placeDescription =
        value != null && isValidDescription(value)
            ? ValidationModel(value, null)
            : ValidationModel(null, FieldsErrors.invalidName);
    submitForm(_placeDescription);

    return _placeDescription;
  }

  bool isValidDescription(String value) {
    return value.isNotEmpty;
  }

  bool _validateFields() {
    return [
      placeCategoryState.value,
      placeNameState.value,
      placeCoordinatesLatState.value,
      placeCoordinatesLonState.value,
      placeDescriptionState.value,
    ].every((element) => element.value != null);
  }

  // create sight
  Future<WMObservable<Place>> addPlace() async {
    List<String> randomPhotos = [
      'https://picsum.photos/1000/800?random=1',
      'https://picsum.photos/1000/800?random=2',
      'https://picsum.photos/1000/800?random=3',
      'https://picsum.photos/1000/800?random=4',
    ];

    Place newPlace = Place(
      name: placeNameState.value.value!,
      type: placeCategoryState.value.value!.engName,
      lat: double.parse(placeCoordinatesLatState.value.value!),
      lng: double.parse(placeCoordinatesLonState.value.value!),
      urls: randomPhotos,
      description: placeDescriptionState.value.value!,
    );
    try {
      final response = await _placeInteractor.addPlace(place: newPlace);
      final Place place = Place.fromJson(response.data);

      return WMObservable(state: WMState.loaded, result: place);
    } on DioError catch (e) {
      return WMObservable(
        state: WMState.error,
        error: _placeInteractor.handleError(e),
      );
    }
  }

  Future<void> _onSelectCategory(PlaceCategory? value) async {
    await placeCategoryState.accept(validateCategory(value));
  }

  Future<void> _onChangeName(String value) async {
    await placeNameState.accept(validateName(value));
  }

  Future<void> _onChangeCoordinatesLat(String value) async {
    await placeCoordinatesLatState.accept(validateCoordinatesLat(value));
  }

  Future<void> _onChangeCoordinatesLon(String value) async {
    await placeCoordinatesLonState.accept(validateCoordinatesLon(value));
  }

  Future<void> _onChangeDescription(String value) async {
    await placeDescriptionState.accept(validateDescription(value));
  }

  Future<void> _onSubmitForm(_) async {
    final bool isFieldsValid = _validateFields();
    await createButtonState.accept(isFieldsValid);
  }
}

/// Field errors texts. Shows in [TextFormField.validator] as [TextFormField.decoration.errorText].
class FieldsErrors {
  static const invalidCategory = '';
  static const invalidName = '';
  static const invalidCoordinates = '';
  static const invalidDescription = '';
}

/// Validation patterns to match.
class FieldsPatterns {
  /// Pattern for double value.
  static final RegExp doublePattern = RegExp('([0-9]*[.]*)?[0-9]+\$');
}

class WMObservable<T> {
  final T? result;
  final NetworkException? error;
  final WMState state;

  WMObservable({
    this.result,
    this.error,
    required this.state,
  });
}

enum WMState {
  loading,
  loaded,
  error,
}
