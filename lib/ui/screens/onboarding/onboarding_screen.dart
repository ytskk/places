import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/screens/onboarding/cubit/onboarding_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final bool isLastPage =
            state.currentPage == state.onboardingPagesContent.length - 1;

        return Scaffold(
          appBar: CustomAppBar(
            actions: [
              // Shows skip button if its not the last page.
              if (!isLastPage)
                TextButton(
                  onPressed: () => context
                      .read<OnboardingCubit>()
                      .completeOnboarding(context),
                  child: Text(AppStrings.tutorAppBarSkipButtonText),
                ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          // To get a transparent background
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _OnboardingPageIndicator(),
              const SizedBox(height: largeSpacing),
              // if (isLastPage) const _OnboardingActionButton(),
              const _OnboardingActionButton(),
            ],
          ),
          body: const _OnboardingPages(),
        );
      },
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

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int pageIndex = 0;
                pageIndex < state.onboardingPagesContent.length;
                pageIndex++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  margin: EdgeInsets.only(right: 4),
                  curve: Curves.easeOut,
                  height: 8,
                  width: state.currentPage == pageIndex ? 24 : 8,
                  decoration: BoxDecoration(
                    color: state.currentPage == pageIndex
                        ? theme.primaryColor
                        : theme.textTheme.bodyText1!.color!.withOpacity(0.54),
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _OnboardingActionButton extends StatelessWidget {
  const _OnboardingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            height: state.currentPage == state.onboardingPagesContent.length - 1
                ? 64
                : 0,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: mediumWrappingPadding,
                child: Button(
                  text: AppStrings.tutorStartButtonTitle.toUpperCase(),
                  buttonPadding: ButtonPadding.UltraWide,
                  onPressed: () => context
                      .read<OnboardingCubit>()
                      .completeOnboarding(context),
                ),
              ),
            ),
          ),
        );
      },
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

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return PageView.builder(
          controller: state.pageController,
          onPageChanged: (page) {
            context.read<OnboardingCubit>().setCurrentPage(page);
          },
          itemCount: state.onboardingPagesContent.length,
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
                      infoListData: InfoListData(
                        iconName:
                            state.onboardingPagesContent.elementAt(index).icon,
                        iconColor: theme.textTheme.bodyText2!.color,
                        iconSize: 128,
                        iconPaddingBottom: 40,
                        title: Text(
                          state.onboardingPagesContent.elementAt(index).title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline3,
                        ),
                        subtitle: Text(
                          state.onboardingPagesContent
                              .elementAt(index)
                              .subtitle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
