import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// One record in search history.
class SearchHistoryRecord extends Equatable {
  final String id;
  final String value;

  SearchHistoryRecord({
    required this.value,
  }) : this.id = ValueKey(value).toString();

  @override
  List<Object?> get props => [id, value];
}
