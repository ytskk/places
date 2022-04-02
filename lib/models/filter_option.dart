import 'dart:developer';

/// Class for describing and controls filter option.
class FilterOption {
  FilterOption({required String name, bool isEnabled = true})
      : this._name = name,
        this._isSelected = isEnabled;

  final String _name;
  bool _isSelected;

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
