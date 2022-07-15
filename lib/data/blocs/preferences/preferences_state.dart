part of 'preferences_cubit.dart';

class PreferencesState extends Equatable {
  const PreferencesState({
    required this.isDarkMode,
    required this.isFirstOpen,
  });

  final bool isDarkMode;
  final bool isFirstOpen;

  PreferencesState copyWith({
    bool? isDarkMode,
    bool? isFirstOpen,
  }) {
    return PreferencesState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isFirstOpen: isFirstOpen ?? this.isFirstOpen,
    );
  }

  @override
  List<Object> get props => [isDarkMode, isFirstOpen];
}
