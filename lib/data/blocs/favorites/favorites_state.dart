part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

/// Loading state
class FavoritesLoadInProgress extends FavoritesState {}

/// Loading success state
class FavoritesLoadSuccess extends FavoritesState {
  final List<Place> favorites;

  const FavoritesLoadSuccess(this.favorites);

  @override
  List<Object> get props => [favorites];

  @override
  String toString() => 'FavoritesLoadSuccess { wantToVisit: $favorites }';
}
