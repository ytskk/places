import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/ui/components/icon_box.dart';

class LoadingProgressIndicator extends StatefulWidget {
  const LoadingProgressIndicator({Key? key}) : super(key: key);

  @override
  State<LoadingProgressIndicator> createState() =>
      _LoadingProgressIndicatorState();
}

class _LoadingProgressIndicatorState extends State<LoadingProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: longDuration * 2,
    );

    _animation = Tween<double>(
      begin: 0,
      end: -1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _animation,
        child: Image.asset(
          AppIcons.loader,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
