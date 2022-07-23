import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/data/db/db_repository.dart';
import 'package:places/domain/app_constants.dart' as constants;
import 'package:places/domain/app_icons.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/ui/navigation/app_route_names.dart';
import 'package:places/ui/navigation/screen_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: constants.splashScreenDuration,
    );
    _animation = Tween(
      begin: 0.0,
      end: -1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: constants.brandCurve,
      ),
    );
    _animationController.repeat();

    _moveToNext(context);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// Controls app loading progress. When it's done, it moves to the next screen.
  ///
  /// On loading shows an animation.
  ///
  /// On push, clears navigation stack.
  Future<void> _moveToNext(BuildContext context) async {
    final options = await context.read<DBRepository>().getFilterOptions();
    context.read<FilterCubit>().loadFilterOptions(options);

    await Future.delayed(
      const Duration(seconds: 2),
      () {
        log('SplashScreen: moving to next screen: ${context.read<PreferencesCubit>().state.isFirstOpen}');
        Navigator.pushReplacementNamed(
          context,
          context.read<PreferencesCubit>().state.isFirstOpen
              ? AppRouteNames.onBoarding
              : AppRouteNames.home,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: constants.brandGradient,
      ),
      // to maintain styles.
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: RotationTransition(
            turns: _animation,
            child: IconBox(
              icon: AppIcons.map_fill_circle,
              color: Colors.white,
              size: 160,
            ),
          ),
        ),
      ),
    );
  }
}
