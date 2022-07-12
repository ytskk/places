import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/navigation/app_route_names.dart';
import 'package:places/ui/screens/onboarding/models/onboarding_page_data.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit()
      : super(
          OnboardingState(
            PageController(initialPage: 0),
            0,
          ),
        );

  void setCurrentPage(int pageIndex) {
    emit(
      state.copyWith(
        currentPage: pageIndex,
      ),
    );
  }

  void _clearOnboardingProgress() {
    state.pageController.dispose();
    state.currentPage = 0;
  }

  void completeOnboarding(BuildContext context) {
    _clearOnboardingProgress();
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRouteNames.home,
      (route) => false,
    );
  }
}
