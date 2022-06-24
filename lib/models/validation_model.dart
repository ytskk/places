/// A class for describing validation and error.
class ValidationModel<T> {
  /// Initialise validation model.
  ///
  /// [value] responds for field controller text value.
  /// [error] — text of the field error in case of failed validation.
  ///
  /// When [error] is not null there is an error, otherwise field is valid.
  ValidationModel(this.value, this.error);

  T? value;
  String? error;

  @override
  String toString() => 'ValidationModel{value: $value, error: $error}';
}
