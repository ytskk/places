import 'package:formz/formz.dart';

enum PlaceNameValidationError {
  empty,
  tooShort,
  tooLong,
}

class PlaceNameConstants {
  static const int minLength = 3;
  static const int maxLength = 100;
}

class PlaceNameModel extends FormzInput<String, PlaceNameValidationError> {
  const PlaceNameModel.pure() : super.pure('');

  const PlaceNameModel.dirty([String value = '']) : super.dirty(value);

  @override
  PlaceNameValidationError? validator(String? value) {
    if (value == null) {
      return PlaceNameValidationError.empty;
    }

    if (value.length < PlaceNameConstants.minLength) {
      return PlaceNameValidationError.tooShort;
    }

    if (value.length > PlaceNameConstants.maxLength) {
      return PlaceNameValidationError.tooLong;
    }

    return null;
  }
}

extension PlaceNameValidationErrorExtension on PlaceNameValidationError {
  String get message {
    switch (this) {
      case PlaceNameValidationError.empty:
        return 'Name is empty';
      case PlaceNameValidationError.tooShort:
        return 'Name is too short, at least ${PlaceNameConstants.minLength} characters';
      case PlaceNameValidationError.tooLong:
        return 'Name is too long, max ${PlaceNameConstants.maxLength} characters';
    }
  }
}
