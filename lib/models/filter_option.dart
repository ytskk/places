import 'dart:developer';

/// Class for describing filter option.
class FilterOption {
  final String _name;
  bool _isSelected;

  FilterOption({required String name, bool isEnabled = true})
      : this._name = name,
        this._isSelected = isEnabled;

  void setSelected(bool value) {
    _isSelected = value;
    log("$this is ${_isSelected ? "" : "un"}selected");
  }

  bool get isSelected => _isSelected;
  String get name => _name;

  @override
  String toString() {
    return _name;
  }
}
