import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
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
              AnimatedSwitcher(
                duration: quickDuration,
                transitionBuilder: (child, animation) => SlideTransition(
                  // opacity: animation,
                  position: Tween<Offset>(
                    begin: Offset(0, -1),
                    end: Offset(0, 0),
                  ).animate(animation),
                  child: child,
                ),
                switchOutCurve: brandCurve,
                child: !isLastPage
                    ? TextButton(
                        onPressed: () => _completeOnboarding(context),
                        child: Text(AppStrings.tutorAppBarSkipButtonText),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          // To get a transparent background
          floatingActionButton: AnimatedSize(
            clipBehavior: Clip.none,
            curve: brandCurve,
            duration: quickDuration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const _OnboardingPageIndicator(),
                const SizedBox(height: largeSpacing),
                const _OnboardingActionButton(),
              ],
            ),
          ),
          body: const _OnboardingPages(),
        );
      },
    );
  }
}

void _completeOnboarding(BuildContext context) {
  context.read<OnboardingCubit>().completeOnboarding(context);
  context.read<PreferencesCubit>().setFirstOpen(false);
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
                  duration: quickDuration,
                  margin: EdgeInsets.only(right: 4),
                  curve: brandCurve,
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
          child: AnimatedCrossFade(
            sizeCurve: brandCurve,
            firstChild: const SizedBox(
              width: double.infinity,
            ),
            secondChild: SizedBox(
              key: const Key('start_button'),
              width: double.infinity,
              child: Padding(
                padding: mediumWrappingPadding,
                child: Button(
                  text: AppStrings.tutorStartButtonTitle.toUpperCase(),
                  buttonPadding: ButtonPadding.UltraWide,
                  onPressed: () => _completeOnboarding(context),
                ),
              ),
            ),
            crossFadeState:
                state.currentPage == state.onboardingPagesContent.length - 1
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
            duration: quickDuration,
          ),
          // child: AnimatedSwitcher(
          //   duration: quickDuration,
          //   transitionBuilder: (child, animation) => SlideTransition(
          //     position: Tween<Offset>(
          //       begin: Offset(0, 0.05),
          //       end: Offset.zero,
          //     ).animate(animation),
          //     child: child,
          //   ),
          //   switchOutCurve: Curves.easeOut,
          //   child: state.currentPage == state.onboardingPagesContent.length - 1
          //       ? SizedBox(
          //           key: const Key('start_button'),
          //           width: double.infinity,
          //           child: Padding(
          //             padding: mediumWrappingPadding,
          //             child: Button(
          //               text: AppStrings.tutorStartButtonTitle.toUpperCase(),
          //               buttonPadding: ButtonPadding.UltraWide,
          //               onPressed: () => _completeOnboarding(context),
          //             ),
          //           ),
          //         )
          //       : const SizedBox.shrink(),
          // ),
          // child: AnimatedContainer(
          //   duration: quickDuration,
          //   curve: brandCurve,
          //   height: state.currentPage == state.onboardingPagesContent.length - 1
          //       ? 64
          //       : 0,
          //   child: SizedBox(
          //     width: double.infinity,
          //     child: Padding(
          //       padding: mediumWrappingPadding,
          //       child: Button(
          //         text: AppStrings.tutorStartButtonTitle.toUpperCase(),
          //         buttonPadding: ButtonPadding.UltraWide,
          //         onPressed: () => _completeOnboarding(context),
          //       ),
          //     ),
          //   ),
          // ),
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
            log('Onboarding page changed to $page');
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
                      animate: true,
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
