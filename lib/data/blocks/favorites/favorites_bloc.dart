import 'package:bloc/bloc.dart';
import 'package:places/data/blocks/favorites/favorites_event.dart';
import 'package:places/data/blocks/favorites/favorites_state.dart';
import 'package:places/data/interactor/favorites_interactor.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesInteractor _favoritesInteractor;

  FavoritesBloc(this._favoritesInteractor) : super(FavoritesLoadInProgress()) {
    on<FavoritesEvent>((event, emit) async {
      if (event is FavoritesLoad) {
        await onFavoritesLoad(FavoritesEvent, emit);
      }
    });
  }

  onFavoritesLoad(
    FavoritesEvent,
    Emitter<FavoritesState> emit,
  ) async {
    final favorites = await _favoritesInteractor.getFavorites();
    emit(FavoritesLoadSuccess(favorites));
  }
}
