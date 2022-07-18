import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/ui/components/custom_navigation_bar.dart';
import 'package:places/ui/screens/main_screen/cubit/main_navigation_cubit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    log('MainScreen: initState');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavigationCubit, MainNavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: state.routes.elementAt(state.currentIndex),
          bottomNavigationBar: CustomNavigationBar(
            onTap: (int index) {
              context.read<MainNavigationCubit>().setCurrentIndex(index);
            },
            currentIndex: state.currentIndex,
          ),
        );
      },
    );
  }
}
