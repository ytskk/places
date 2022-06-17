import 'package:places/data/redux/actions/search_action.dart';
import 'package:places/data/redux/states/app_state.dart';
import 'package:places/data/redux/states/search_state.dart';

AppState loadSearchReducer(AppState state, LoadSearchAction action) {
  return state.cloneWith(searchState: LoadingSearchState());
}

AppState resultSearchReducer(AppState state, ResultSearchAction action) {
  return state.cloneWith(searchState: ResultSearchState(action.places));
}
