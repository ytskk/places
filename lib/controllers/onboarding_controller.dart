import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';

/// Controller for onboarding screen.
///
/// Controls current page index and page content.
class Onboarding extends ChangeNotifier {
  // definitions.
  int _currentPage = 0;
  List<OnboardingPageData> _tutorContent = [
    OnboardingPageData(
      title: AppStrings.tutorScreenWelcomeTitle,
      subtitle: AppStrings.tutorScreenWelcomeSubtitle,
      icon: AppIcons.travel_guide,
    ),
    OnboardingPageData(
      title: AppStrings.tutorScreenBuildDirectionTitle,
      subtitle: AppStrings.tutorScreenBuildDirectionSubtitle,
      icon: AppIcons.bag,
    ),
    OnboardingPageData(
      title: AppStrings.tutorScreenAddPlaceTitle,
      subtitle: AppStrings.tutorScreenAddPlaceSubtitle,
      icon: AppIcons.pointer,
    ),
  ];

  // getters.
  int get currentPage => _currentPage;

  List<OnboardingPageData> get tutorContent => _tutorContent;

  // setters.
  set setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}

/// class OnboardingPageData contains icon name from [AppIcons], title, and subtitle.
///
/// Provides data for onboarding screen.
class OnboardingPageData {
  const OnboardingPageData({
    this.icon,
    required this.title,
    required this.subtitle,
  });

  final String? icon;
  final String title;
  final String subtitle;
}
