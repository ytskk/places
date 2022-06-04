import 'package:places/data/redux/app_state.dart';
import 'package:places/data/redux/search_action.dart';
import 'package:places/data/redux/search_reducer.dart';
import 'package:redux/redux.dart';

final Reducer<AppState> reducer = combineReducers([
  TypedReducer<AppState, LoadSearchAction>(loadSearchReducer),
  TypedReducer<AppState, ResultSearchAction>(resultSearchReducer),
]);
