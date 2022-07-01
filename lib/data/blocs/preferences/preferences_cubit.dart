import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/repository/local_repository.dart';

part 'package:places/data/blocs/preferences/preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit(this._localRepository)
      : super(
          PreferencesState(
            isDarkMode: false,
            isFirstOpen: true,
          ),
        );

  final LocalRepository _localRepository;

  Future<void> loadPreferences() async {
    log('loading preferences');
    final isDarkMode = await _localRepository.isDarkMode;
    final isFirstOpen = await _localRepository.isFirstOpen;

    emit(
      state.copyWith(
        isDarkMode: isDarkMode,
        isFirstOpen: isFirstOpen,
      ),
    );
  }

  Future<void> _turnOnDarkMode() async {
    await _localRepository.setDarkMode(true);
    emit(
      state.copyWith(
        isDarkMode: true,
      ),
    );
  }

  Future<void> _turnOffDarkMode() async {
    await _localRepository.setDarkMode(false);
    emit(
      state.copyWith(
        isDarkMode: false,
      ),
    );
  }

  void toggleDarkMode() {
    log('toggling dark mode');
    if (state.isDarkMode) {
      _turnOffDarkMode();
    } else {
      _turnOnDarkMode();
    }
  }
}
