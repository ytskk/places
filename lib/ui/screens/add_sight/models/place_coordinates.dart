import 'package:formz/formz.dart';

enum PlaceCoordinatesValidationError {
  empty,
  invalid,
}

class PlaceCoordinatesModel
    extends FormzInput<String, PlaceCoordinatesValidationError> {
  const PlaceCoordinatesModel.pure() : super.pure('');

  const PlaceCoordinatesModel.dirty([String value = '']) : super.dirty(value);

  @override
  PlaceCoordinatesValidationError? validator(String? value) {
    if (value == null || value.isEmpty) {
      return PlaceCoordinatesValidationError.empty;
    }
    if (double.tryParse(value) == null) {
      return PlaceCoordinatesValidationError.invalid;
    }

    return null;
  }
}

extension PlaceCoordinatesValidationErrorExtension
    on PlaceCoordinatesValidationError {
  String get message {
    switch (this) {
      case PlaceCoordinatesValidationError.empty:
        return 'Coordinate is empty';
      case PlaceCoordinatesValidationError.invalid:
        return 'Coordinate is invalid';
    }
  }
}
