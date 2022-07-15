part of 'favorites_cubit.dart';

abstract class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {}

class FavoritesLoadInitialInProgress extends FavoritesState {}

class FavoritesLoadInProgress extends FavoritesState {}

class FavoritesLoadSuccess extends FavoritesState {
  final List<Place> favorites;

  FavoritesLoadSuccess(this.favorites);
}
