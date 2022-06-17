import 'package:places/data/redux/actions/search_action.dart';
import 'package:places/data/redux/reducers/search_reducer.dart';
import 'package:places/data/redux/states/app_state.dart';
import 'package:redux/redux.dart';

final Reducer<AppState> reducer = combineReducers([
  TypedReducer<AppState, LoadSearchAction>(loadSearchReducer),
  TypedReducer<AppState, ResultSearchAction>(resultSearchReducer),
]);
