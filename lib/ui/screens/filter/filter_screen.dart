import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/blocs/blocs.dart';
import 'package:places/data/db/db_provider.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/filter_option.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/filter_button.dart';
import 'package:places/ui/components/range_selector.dart';
import 'package:places/ui/components/row_group_sliver.dart';
import 'package:places/ui/screens/filter/bloc/filtering_places.dart';
import 'package:places/utils/extensions/pluralize_extension.dart';
import 'package:places/utils/screen_sizes.dart';
import 'package:places/utils/string_manipulations.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;

    return Scaffold(
      appBar: CustomAppBar(
        leading: BackButton(
          color: bodyText2!.color,
        ),
        actions: [
          const _FilterClearOptionsButton(),
        ],
      ),
      body: SafeArea(
        child: BlocListener<FilterCubit, FilterState>(
          listener: (context, state) async {
            context.read<FilteringPlacesBloc>().add(
                  FilteringPlacesLoad(
                    radiusFrom: state.radiusValues.start,
                    radiusTo: state.radiusValues.end,
                    selectedOptions: state.getSelectedOptions(),
                  ),
                );
          },
          child: CustomScrollView(
            slivers: [
              const FilterCategoryHeader(),
              const _FilterButtonsTable(),
              const _FilterRangeSelector(),
              const _FilterShowResultsButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterCategoryHeader extends StatelessWidget {
  const FilterCategoryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BuildFilterCategoryTitle(
        title: Text(AppStrings.filterScreenFilterTitle.toUpperCase()),
      ),
    );
  }
}

class _FilterClearOptionsButton extends StatelessWidget {
  const _FilterClearOptionsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<FilterCubit>().clearOptions();
      },
      child: Text(AppStrings.filterScreenActionClear),
    );
  }
}

/// Returns [FilterOption] buttons, depends on screen height.
///
/// If screen height is less than [_screenSizeSmall], returns [_FilterButtonsTableSmall].
class _FilterButtonsTable extends StatelessWidget {
  const _FilterButtonsTable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (BuildContext context, state) {
        final screenSize =
            resolveScreenHeightSize(MediaQuery.of(context).size.height);

        switch (screenSize) {
          case ScreenSizes.Small:
            return _FilterButtonsTableSmall(
              content: state.filterOptions,
            );
          default:
            return _FilterButtonsTableMedium(
              content: state.filterOptions,
            );
        }
      },
    );
  }
}

class _FilterButtonsTableSmall extends StatelessWidget {
  const _FilterButtonsTableSmall({
    Key? key,
    required this.content,
  }) : super(key: key);

  final List<FilterOption> content;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        child: ListView.builder(
          primary: false,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(smallSpacing),
            child: FilterButton(
              category: content.elementAt(index),
              onTap: () {
                context.read<FilterCubit>().toggleOption(
                      content.elementAt(index),
                    );
              },
            ),
          ),
          scrollDirection: Axis.horizontal,
          itemCount: content.length,
          padding: const EdgeInsets.symmetric(horizontal: smallSpacing),
        ),
      ),
    );
  }
}

class _FilterButtonsTableMedium extends StatelessWidget {
  const _FilterButtonsTableMedium({
    Key? key,
    required this.content,
  }) : super(key: key);

  final List<FilterOption> content;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: smallSpacing),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(smallSpacing),
              child: FilterButton(
                category: content[index],
                onTap: () {
                  context.read<FilterCubit>().toggleOption(
                        content.elementAt(index),
                      );
                },
              ),
            );
          },
          childCount: content.length,
        ),
      ),
    );
  }
}

class _FilterRangeSelector extends StatelessWidget {
  const _FilterRangeSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return FilterRowGroup(
          title: Text(
            AppStrings.filterScreenRangeSelectionGroupTitle,
            style: bodyText2,
          ),
          titleAfter: Text(
            getRangeValuesString(state.radiusValues),
            style: TextStyle(fontSize: 16),
          ),
          child: const _RangeSelection(),
        );
      },
    );
  }
}

class _RangeSelection extends StatelessWidget {
  const _RangeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        return RangeSelector(
          initialRangeValues: state.initialRadiusValues,
          values: state.radiusValues,
          onChanged: (newValues) =>
              context.read<FilterCubit>().changeRadius(newValues),
        );
      },
    );
  }
}

class _FilterShowResultsButton extends StatelessWidget {
  const _FilterShowResultsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      fillOverscroll: true,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: BlocBuilder<FilteringPlacesBloc, FilteringPlacesState>(
              builder: (BuildContext context, state) {
                return ElevatedButton(
                  onPressed: state is FilteringPlacesLoadSuccess &&
                          state.places.length > 0
                      ? () {
                          Navigator.of(context).pop();
                          context.read<PlacesBloc>().add(
                                PlacesSet(state.places),
                              );
                          context.read<DBProvider>().setFilterOptions(
                                context.read<FilterCubit>().getFilterString(),
                              );
                        }
                      : null,
                  child: Text(
                    state is FilteringPlacesLoadSuccess
                        ? state.places.length > 0
                            ? '${AppStrings.filterScreenFilterShow} (${state.places.length} ${pluralize(
                                state.places.length,
                                PluralWords.place,
                              )})'
                            : AppStrings.filterScreenFilterShowEmpty
                        : state is FilteringPlacesLoadInProgress
                            ? AppStrings.filterScreenFilterShowLoading
                            : AppStrings.filterScreenFilterShow,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
