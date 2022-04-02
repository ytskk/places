import 'package:flutter/cupertino.dart';
import 'package:places/mocks.dart';
import 'package:places/models/sight.dart';

class SightSearch extends ChangeNotifier {
  late TextEditingController _searchController;

  final List<ActivityRecord> _recentActivity = [];

  List<ActivityRecord> get recentActivity => _recentActivity;

  void addActivity(String activityRecord) {
    // TODO: optimize! Adding only unique element.
    if (_recentActivity
            .indexWhere((element) => element.value == activityRecord) ==
        -1) {
      _recentActivity.add(ActivityRecord(value: activityRecord));
    }
    notifyListeners();
  }

  void removeActivityById(String id) {
    _recentActivity.removeWhere((element) => element.id == id);
    ActivityRecord.count -= 1;
    notifyListeners();
  }

  void removeAllActivities() {
    _recentActivity.clear();
    ActivityRecord.count = 0;
    notifyListeners();
  }

  void bindSearchController(TextEditingController controller) {
    _searchController = controller;
  }

  String get searchControllerText => _searchController.text;

  void setControllerText(String value) {
    _searchController.text = value;
    _searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  List<Sight> searchByName(String query, {List<Sight>? domain}) {
    // TODO: search from filtered results
    return (domain ?? mocks)
        .where((Sight element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

/// Search history item.
class ActivityRecord {
  late final String id;
  final String value;

  static int count = 0;

  ActivityRecord({required String this.value}) {
    this.id = (ActivityRecord.count).toString();
    ActivityRecord.count += 1;
  }
}
