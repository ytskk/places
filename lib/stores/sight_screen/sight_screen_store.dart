import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place_model.dart';

part 'sight_screen_store.g.dart';

class SightListStore = SightListStoreBase with _$SightListStore;

abstract class SightListStoreBase with Store {
  final PlaceInteractor _placeInteractor;

  SightListStoreBase(this._placeInteractor);

  @observable
  ObservableFuture<List<Place>>? placesFuture;

  @action
  Future<void> fetchPlaces({
    required double radiusTo,
    required double radiusFrom,
    List<String>? types,
  }) async {
    final future = _placeInteractor.getPlaces(
      radiusTo: radiusTo,
      radiusFrom: radiusFrom,
      types: types,
    );

    placesFuture = ObservableFuture(future);
  }
}
