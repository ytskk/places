import 'package:flutter/material.dart';
import 'package:places/controllers/onboarding_controller.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_routes.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();

    context.read<Onboarding>().createPageController();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = context.watch<Onboarding>().currentPage ==
        context.read<Onboarding>().tutorContent.length - 1;

    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          // Shows skip button if its not the last page.
          if (!isLastPage)
            TextButton(
              onPressed: () =>
                  context.read<Onboarding>().completeOnboarding(context),
              child: Text(AppStrings.tutorAppBarSkipButtonText),
            ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // To get a transparent background
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _OnboardingPageIndicator(),
          const SizedBox(height: largeSpacing),
          if (isLastPage) const _OnboardingActionButton(),
        ],
      ),
      body: _OnboardingPages(),
    );
  }
}

/// Page indicator is a row of dots, one for each page.
/// The current page is highlighted by primary color.
class _OnboardingPageIndicator extends StatelessWidget {
  const _OnboardingPageIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int currentPage = context.watch<Onboarding>().currentPage;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int pageIndex = 0;
            pageIndex < context.read<Onboarding>().tutorContent.length;
            pageIndex++)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              margin: EdgeInsets.only(right: 4),
              curve: Curves.easeOut,
              height: 8,
              width: currentPage == pageIndex ? 24 : 8,
              decoration: BoxDecoration(
                color: currentPage == pageIndex
                    ? theme.primaryColor
                    : theme.textTheme.bodyText1!.color!.withOpacity(0.54),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
      ],
    );
  }
}

class _OnboardingActionButton extends StatelessWidget {
  const _OnboardingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: mediumWrappingPadding,
          child: Button(
            text: AppStrings.tutorStartButtonTitle.toUpperCase(),
            buttonPadding: ButtonPadding.UltraWide,
            onPressed: () =>
                context.read<Onboarding>().completeOnboarding(context),
          ),
        ),
      ),
    );
  }
}

class _OnboardingPages extends StatefulWidget {
  const _OnboardingPages({Key? key}) : super(key: key);

  @override
  State<_OnboardingPages> createState() => _OnboardingPagesState();
}

class _OnboardingPagesState extends State<_OnboardingPages> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onboardingProvider = context.read<Onboarding>();

    return PageView.builder(
      controller: onboardingProvider.pageController,
      onPageChanged: (page) {
        onboardingProvider.setPage = page;
      },
      itemCount: onboardingProvider.tutorContent.length,
      itemBuilder: (BuildContext context, int index) {
        return Center(
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              Padding(
                // To center content vertically. And to avoid overlapping of text and indicator.
                padding: const EdgeInsets.only(bottom: 120),
                child: InfoList(
                  iconName: onboardingProvider.tutorContent[index].icon,
                  iconColor: theme.textTheme.bodyText2!.color,
                  iconSize: 128,
                  iconPaddingBottom: 40,
                  title: Text(
                    onboardingProvider.tutorContent[index].title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline3,
                  ),
                  subtitle: Text(
                    onboardingProvider.tutorContent[index].subtitle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
