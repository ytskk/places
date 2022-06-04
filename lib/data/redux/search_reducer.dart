import 'package:places/data/redux/app_state.dart';
import 'package:places/data/redux/search_action.dart';
import 'package:places/data/redux/search_state.dart';

AppState loadSearchReducer(AppState state, LoadSearchAction action) {
  return state.cloneWith(searchState: LoadingSearchState());
}

AppState resultSearchReducer(AppState state, ResultSearchAction action) {
  return state.cloneWith(searchState: ResultSearchState(action.places));
}
