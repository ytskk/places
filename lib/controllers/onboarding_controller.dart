import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_routes.dart';
import 'package:places/domain/app_strings.dart';
import 'package:provider/provider.dart';

/// Controller for onboarding screen.
///
/// Controls current page index and page content.
class Onboarding extends ChangeNotifier {
  // definitions.
  int _currentPage = 0;
  final List<OnboardingPageData> _onboardingPagesContent = [
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
  late PageController _pageController;

  // getters.
  int get currentPage => _currentPage;

  List<OnboardingPageData> get tutorContent => _onboardingPagesContent;

  PageController get pageController => _pageController;

  // setters.
  set setPage(int page) {
    _currentPage = page;
    notifyListeners();
  }

  // methods.
  void createPageController() {
    _pageController = PageController(initialPage: 0);
  }

  void clearOnboardingProgress() {
    _pageController.dispose();
    _currentPage = 0;
  }

  // temporary unused method.
  // void jumpToLastPage() {
  //   _pageController.animateToPage(
  //     _onboardingPagesContent.length - 1,
  //     curve: Curves.easeOut,
  //     duration: Duration(milliseconds: 500),
  //   );
  // }

  void completeOnboarding(BuildContext context) {
    clearOnboardingProgress();
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
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
