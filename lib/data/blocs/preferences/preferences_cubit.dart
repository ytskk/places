import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:places/data/db/db.dart';

part 'package:places/data/blocs/preferences/preferences_state.dart';

class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit(this._dbProvider)
      : super(
          PreferencesState(
            isDarkMode: false,
            isFirstOpen: true,
          ),
        );

  final DBRepository _dbProvider;

  Future<void> loadPreferences() async {
    log('loading preferences', name: 'PreferencesCubit::loadPreferences');
    final isDarkMode = await _dbProvider.isDarkMode();
    final isFirstOpen = await _dbProvider.isFirstOpen();

    emit(
      state.copyWith(
        isDarkMode: isDarkMode,
        isFirstOpen: isFirstOpen,
      ),
    );

    log('loaded preferences', name: 'PreferencesCubit::loadPreferences');
  }

  Future<void> _turnOnDarkMode() async {
    await _dbProvider.setDarkMode(true);
    emit(
      state.copyWith(
        isDarkMode: true,
      ),
    );
  }

  Future<void> _turnOffDarkMode() async {
    await _dbProvider.setDarkMode(false);
    emit(
      state.copyWith(
        isDarkMode: false,
      ),
    );
  }

  void toggleDarkMode() {
    log('toggling dark mode', name: 'PreferencesCubit::toggleDarkMode');
    if (state.isDarkMode) {
      _turnOffDarkMode();
    } else {
      _turnOnDarkMode();
    }
  }

  void setFirstOpen(bool isFirstOpen) {
    _dbProvider.setFirstOpen(isFirstOpen);
    emit(
      state.copyWith(
        isFirstOpen: isFirstOpen,
      ),
    );
  }
}
