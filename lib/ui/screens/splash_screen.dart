import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/domain/app_constants.dart' as constants;
import 'package:places/domain/app_icons.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:places/ui/navigation/screen_factory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _moveToNext(context);
  }

  /// Controls app loading progress. When it's done, it moves to the next screen.
  ///
  /// On loading shows an animation.
  ///
  /// On push, clears navigation stack.
  Future<void> _moveToNext(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 2),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                context.read<PreferencesCubit>().state.isFirstOpen
                    ? ScreenFactory().makeOnboardingScreen()
                    : ScreenFactory().makeMainScreen(),
          ),
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
