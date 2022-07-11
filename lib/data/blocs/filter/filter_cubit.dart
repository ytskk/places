import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:places/models/filter_option.dart';
import 'package:places/models/sight.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState());

  void toggleOption(FilterOption filterOption) {
    emit(
      state.copyWith(
        filterOptions: state.filterOptions
            .map(
              (option) => option.engName == filterOption.engName
                  ? option.copyWith(isSelected: !option.isSelected)
                  : option,
            )
            .toList(),
      ),
    );
  }

  void clearOptions() {
    emit(
      state.copyWith(
        radiusValues: state.initialRadiusValues,
        filterOptions: state.filterOptions
            .map(
              (option) => option.copyWith(isSelected: true),
            )
            .toList(),
      ),
    );
  }

  void changeRadius(RangeValues radius) {
    emit(
      state.copyWith(
        radiusValues: radius,
      ),
    );
  }
}
