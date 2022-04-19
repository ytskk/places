import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart' as constants;
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_routes.dart';
import 'package:places/ui/components/icon_box.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Controls app loading status.
  ///
  /// TODO: implement loading status.
  late Future<bool> isInitialized;

  @override
  void initState() {
    super.initState();

    _moveToNext();
  }

  /// Controls app loading progress. When it's done, it moves to the next screen.
  ///
  /// On loading shows an animation.
  ///
  /// On push, clears navigation stack.
  Future<void> _moveToNext() async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        print('navigating to the next screen');
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.onboarding,
          (route) => false,
          arguments: AppRoutes.home,
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
          child: IconBox(
            icon: AppIcons.map_fill_circle,
            color: Colors.white,
            size: 160,
          ),
        ),
      ),
    );
  }
}
