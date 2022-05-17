// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sight_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SightListStore on SightListStoreBase, Store {
  late final _$placesFutureAtom =
      Atom(name: 'SightListStoreBase.placesFuture', context: context);

  @override
  ObservableFuture<List<Place>>? get placesFuture {
    _$placesFutureAtom.reportRead();
    return super.placesFuture;
  }

  @override
  set placesFuture(ObservableFuture<List<Place>>? value) {
    _$placesFutureAtom.reportWrite(value, super.placesFuture, () {
      super.placesFuture = value;
    });
  }

  late final _$fetchPlacesAsyncAction =
      AsyncAction('SightListStoreBase.fetchPlaces', context: context);

  @override
  Future<void> fetchPlaces(
      {required double radiusTo,
      required double radiusFrom,
      List<String>? types}) {
    return _$fetchPlacesAsyncAction.run(() => super
        .fetchPlaces(radiusTo: radiusTo, radiusFrom: radiusFrom, types: types));
  }

  @override
  String toString() {
    return '''
placesFuture: ${placesFuture}
    ''';
  }
}
