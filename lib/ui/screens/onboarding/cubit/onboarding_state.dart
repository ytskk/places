part of 'onboarding_cubit.dart';

class OnboardingState extends Equatable {
  OnboardingState(
    this.pageController,
    this.currentPage,
  );

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

  List<OnboardingPageData> get onboardingPagesContent =>
      _onboardingPagesContent;

  final PageController pageController;
  int currentPage;

  copyWith({
    int? currentPage,
  }) {
    return OnboardingState(
      this.pageController,
      currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [currentPage];
}
