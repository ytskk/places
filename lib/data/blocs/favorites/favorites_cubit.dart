import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:places/data/interactor/favorites_interactor.dart';
import 'package:places/data/model/place_model.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(
    this._favoritesInteractor,
  ) : super(FavoritesInitial());

  final FavoritesInteractor _favoritesInteractor;

  void loadFavorites() async {
    log('loading favorites');
    if (state is FavoritesLoadInitialInProgress) {
      emit(FavoritesLoadInitialInProgress());
    }

    final List<Place> favorites = await _favoritesInteractor.getFavorites();
    emit(FavoritesLoadSuccess(favorites));
  }

  Future<bool> isFavorite(Place place) async {
    return await _favoritesInteractor.isFavorite(place);
  }

  void toggleFavorite(Place place) async {
    if (state is FavoritesLoadSuccess) {
      final List<Place> favorites = (state as FavoritesLoadSuccess).favorites;
      if (favorites.contains(place)) {
        removeFromFavorites(place);

        return;
      }
    }

    addToFavorites(place);
  }

  void setPlannedAt(Place place, DateTime? date) async {
    await _favoritesInteractor.setPlannedAt(place, date);
    loadFavorites();
  }

  void removeFromFavorites(Place place) async {
    log('removing from favorites');
    await _favoritesInteractor.removeFromFavorites(place);
    loadFavorites();
  }

  void addToFavorites(Place place) async {
    await _favoritesInteractor.addToFavorites(place);
    loadFavorites();
  }
}
