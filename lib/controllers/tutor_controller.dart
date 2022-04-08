import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';

class Tutor extends ChangeNotifier {
  // definitions.
  int _currentPage = 0;
  List<TutorPageData> _tutorContent = [
    TutorPageData(
      title: AppStrings.tutorScreenWelcomeTitle,
      subtitle: AppStrings.tutorScreenWelcomeSubtitle,
      icon: AppIcons.travel_guide,
    ),
    TutorPageData(
      title: AppStrings.tutorScreenBuildDirectionTitle,
      subtitle: AppStrings.tutorScreenBuildDirectionSubtitle,
      icon: AppIcons.bag,
    ),
    TutorPageData(
      title: AppStrings.tutorScreenAddPlaceTitle,
      subtitle: AppStrings.tutorScreenAddPlaceSubtitle,
      icon: AppIcons.pointer,
    ),
  ];

  // getters.
  int get currentPage => _currentPage;

  List<TutorPageData> get tutorContent => _tutorContent;

  // setters.
  set setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}

/// class TutorPageData contains icon name from [AppIcons], title, and subtitle.
class TutorPageData {
  const TutorPageData({
    this.icon,
    required this.title,
    required this.subtitle,
  });

  final String? icon;
  final String title;
  final String subtitle;
}
