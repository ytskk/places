part of 'main_navigation_cubit.dart';

class MainNavigationState extends Equatable {
  MainNavigationState(this._currentIndex);

  // definitions
  final int _currentIndex;
  final List _routes = [
    ScreenFactory().makeSightScreen(),
    ScreenFactory().makeSightScreen(),
    ScreenFactory().makeFavoritesScreen(),
    ScreenFactory().makeSettingsScreen(),
  ];

  // getters
  int get currentIndex => _currentIndex;
  List get routes => _routes;

  // copy with
  MainNavigationState copyWith({
    int? currentIndex,
  }) {
    return MainNavigationState(
      currentIndex ?? this._currentIndex,
    );
  }

  @override
  List<Object?> get props => [
        _currentIndex,
        _routes,
      ];
}
