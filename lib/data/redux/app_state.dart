import 'package:places/data/redux/search_state.dart';

class AppState {
  final SearchState searchState;

  AppState({
    SearchState? searchState,
  }) : this.searchState = searchState ?? InitialSearchState();

  AppState cloneWith({SearchState? searchState}) {
    print('cloning with searchState: $searchState');

    return AppState(searchState: searchState ?? this.searchState);
  }
}
