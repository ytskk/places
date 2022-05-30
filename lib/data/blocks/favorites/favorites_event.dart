import 'package:equatable/equatable.dart';
import 'package:places/data/model/place_model.dart';

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
