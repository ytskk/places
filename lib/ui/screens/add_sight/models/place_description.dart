import 'package:formz/formz.dart';

enum PlaceDescriptionValidationError {
  tooLong,
}

class PlaceDescriptionConstants {
  static const int maxLength = 1000;
}

class PlaceDescriptionModel
    extends FormzInput<String?, PlaceDescriptionValidationError> {
  const PlaceDescriptionModel.pure() : super.pure('');

  const PlaceDescriptionModel.dirty([String value = '']) : super.dirty(value);

  @override
  PlaceDescriptionValidationError? validator(String? value) {
    if (value != null && value.length > PlaceDescriptionConstants.maxLength) {
      return PlaceDescriptionValidationError.tooLong;
    }

    return null;
  }
}

extension PlaceDescriptionValidationErrorExtension
    on PlaceDescriptionValidationError {
  String get message {
    switch (this) {
      case PlaceDescriptionValidationError.tooLong:
        return 'Description is too long, max ${PlaceDescriptionConstants.maxLength} characters';
    }
  }
}
