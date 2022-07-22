import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/ui/navigation/screen_factory.dart';

part 'main_navigation_state.dart';

class MainNavigationCubit extends Cubit<MainNavigationState> {
  MainNavigationCubit()
      : super(
          MainNavigationState(0),
        );

  void setCurrentIndex(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
      ),
    );
  }
}
