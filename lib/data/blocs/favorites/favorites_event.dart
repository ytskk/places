part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class FavoritesLoad extends FavoritesEvent {}

class FavoritesAdd extends FavoritesEvent {
  final Place place;

  const FavoritesAdd(this.place);

  @override
  List<Object?> get props => [place];
}
