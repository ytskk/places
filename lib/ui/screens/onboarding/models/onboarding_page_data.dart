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
