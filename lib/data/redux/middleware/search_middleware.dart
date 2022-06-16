import 'package:places/data/interactor/place_network_interactor.dart';
import 'package:places/data/redux/actions/search_action.dart';
import 'package:places/data/redux/states/app_state.dart';
import 'package:redux/redux.dart';

class SearchMiddleware implements MiddlewareClass<AppState> {
  final PlaceNetworkInteractor _placeNetworkInteractor;

  SearchMiddleware(this._placeNetworkInteractor);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is LoadSearchAction) {
      _placeNetworkInteractor.searchPlace(filterOptions: action.filter).then(
            (value) => store.dispatch(
              ResultSearchAction(value),
            ),
          );
    }

    next(action);
  }
}
