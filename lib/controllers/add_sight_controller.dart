import 'package:flutter/material.dart';
import 'package:places/models/sight.dart';

class AddSight extends ChangeNotifier {
  ValidationModel _sightCategory = ValidationModel(null, null);
  ValidationModel _sightName = ValidationModel(null, null);
  ValidationModel _sightCoordinatesLat = ValidationModel(null, null);
  ValidationModel _sightCoordinatesLon = ValidationModel(null, null);
  ValidationModel _sightDescription = ValidationModel(null, null);

  ValidationModel get category => _sightCategory;
  final List _sightImages = [];

  List get images => _sightImages;

  void addImage() {
    _sightImages.add(UniqueKey());
    notifyListeners();
  }

  void removeImage(Key key) {
    _sightImages.remove(key);
    notifyListeners();
  }

  void validateCategory(String? value) {
    _sightCategory = value != null && isValidCategory(value)
        ? ValidationModel(value, null)
        : ValidationModel(null, FieldsErrors.invalidCategory);
    notifyListeners();
  }

  bool isValidCategory(String value) {
    return value.isNotEmpty;
  }

  ValidationModel get name => _sightName;

  void validateName(String? value) {
    _sightName = value != null && isValidName(value)
        ? ValidationModel(value, null)
        : ValidationModel(null, FieldsErrors.invalidName);
    notifyListeners();
  }

  bool isValidName(String value) {
    return value.isNotEmpty;
  }

  ValidationModel get coordinatesLat => _sightCoordinatesLat;

  void validateCoordinatesLat(String? value) {
    _sightCoordinatesLat = value != null && isValidCoordinates(value)
        ? ValidationModel(value, null)
        : ValidationModel(null, FieldsErrors.invalidName);
    ;
    notifyListeners();
  }

  bool isValidCoordinates(String value) {
    return value.isNotEmpty && FieldsPatterns.doublePattern.hasMatch(value);
  }

  ValidationModel get coordinatesLon => _sightCoordinatesLat;

  void validateCoordinatesLon(String? value) {
    _sightCoordinatesLon = value != null && isValidCoordinates(value)
        ? ValidationModel(value, null)
        : ValidationModel(null, FieldsErrors.invalidName);
    ;
    notifyListeners();
  }

  ValidationModel get description => _sightDescription;

  void validateDescription(String? value) {
    _sightDescription = value != null && isValidDescription(value)
        ? ValidationModel(value, null)
        : ValidationModel(null, FieldsErrors.invalidName);
    notifyListeners();
  }

  bool isValidDescription(String value) {
    return value.isNotEmpty;
  }

  bool validateFields() {
    return [
      _sightName,
      _sightCategory,
      _sightCoordinatesLat,
      _sightCoordinatesLon,
      _sightDescription,
    ].every((element) => element.value != null);
  }

  Sight createSight() {
    return Sight(
      name: _sightName.value!,
      details: _sightDescription.value!,
      lat: double.parse(_sightCoordinatesLat.value!),
      lon: double.parse(_sightCoordinatesLon.value!),
      type: _sightCategory.value!,
    );
  }

  void clearFields() {
    _sightImages.clear();
    _sightCategory = ValidationModel(null, null);
    _sightName = ValidationModel(null, null);
    _sightCoordinatesLat = ValidationModel(null, null);
    _sightCoordinatesLon = ValidationModel(null, null);
    _sightDescription = ValidationModel(null, null);
    print("cleared");
  }
}

/// A class for describing validation and error.
class ValidationModel {
  /// Initialise validation model.
  ///
  /// [value] responds for field controller text value.
  /// [error] — text of the field error in case of failed validation.
  ///
  /// When [error] is not null there is an error, otherwise field is valid.
  ValidationModel(this.value, this.error);

  String? value;
  String? error;
}

/// Field errors texts. Shows in [TextFormField.validator] as [TextFormField.decoration.errorText].
class FieldsErrors {
  static const invalidCategory = "";
  static const invalidName = "";
  static const invalidCoordinates = "";
  static const invalidDescription = "";
}

/// Validation patterns to match.
class FieldsPatterns {
  /// Pattern for double value.
  static final RegExp doublePattern = RegExp(r'^[+-]?([0-9]*[.])?[0-9]+$');
}
