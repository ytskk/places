import 'package:formz/formz.dart';
import 'package:places/models/sight.dart';

enum PlaceCategoryValidationError {
  empty,
}

class PlaceCategoryModel
    extends FormzInput<PlaceCategory?, PlaceCategoryValidationError> {
  const PlaceCategoryModel.pure() : super.pure(null);

  const PlaceCategoryModel.dirty([PlaceCategory? value = null])
      : super.dirty(value);

  @override
  PlaceCategoryValidationError? validator(PlaceCategory? value) {
    return value == null ? PlaceCategoryValidationError.empty : null;
  }
}

extension PlaceCategoryValidationErrorExtension
    on PlaceCategoryValidationError {
  String get message {
    switch (this) {
      case PlaceCategoryValidationError.empty:
        return 'Category is empty';
    }
  }
}
