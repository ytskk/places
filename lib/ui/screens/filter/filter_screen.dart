import 'package:flutter/material.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/models/coordinates.dart';
import 'package:places/models/filter_option.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/filter_button.dart';
import 'package:places/ui/components/range_selector.dart';
import 'package:places/utils/coordinates.dart';
import 'package:places/utils/string_manipulations.dart';
import 'package:provider/provider.dart';

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
          TextButton(
            onPressed: () {
              print("Clear action clicked");
              context.read<Filter>().clearFilterOptions();
            },
            child: Text(AppStrings.filterScreenActionClear),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const FilterCategoryHeader(),
            _FilterButtonsTable(),
            FilterRowGroup(
              title: Text(
                AppStrings.filterScreenRangeSelectionGroupTitle,
                style: bodyText2,
              ),
              titleAfter: Text(
                getRangeValuesString(context.watch<Filter>().rangeValues),
                style: TextStyle(fontSize: 16),
              ),
              child: _RangeSelection(
                rangeValues: RangeValues(100, 20000),
              ),
            ),
            // _RangeSelection(),
          ],
        ),
      ),
      bottomNavigationBar: _FilterShowResultButton(),
    );
  }
}

class FilterCategoryHeader extends StatelessWidget {
  const FilterCategoryHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _BuildFilterCategoryTitle(
        title: Text(AppStrings.filterScreenFilterTitle.toUpperCase()),
      ),
    );
  }
}

class _BuildFilterCategoryTitle extends StatelessWidget {
  final Text title;
  final Text titleAfter;

  const _BuildFilterCategoryTitle({
    Key? key,
    required Text this.title,
    Text this.titleAfter = const Text(""),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.data!,
            style:
                textTheme.bodyText1!.copyWith(fontSize: 12).merge(title.style),
          ),
          if (titleAfter.data!.length > 0)
            Text(
              titleAfter.data!,
              style: textTheme.bodyText1!
                  .copyWith(
                    fontSize: 12,
                  )
                  .merge(titleAfter.style),
            ),
        ],
      ),
    );
  }
}

/// Returns [FilterOption] buttons from parsed sight types from mock.dart.
class _FilterButtonsTable extends StatelessWidget {
  const _FilterButtonsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get all categories
    final List<FilterOption> categories = context.read<Filter>().filterOptions;

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: FilterButton(
              category: categories[index],
              onTap: () {
                context.read<Filter>().toggleCategory(categories[index]);
              },
            ),
          );
        },
        childCount: categories.length,
      ),
    );
  }
}

class _RangeSelection extends StatelessWidget {
  final RangeValues _values;

  const _RangeSelection({Key? key, required RangeValues rangeValues})
      : _values = rangeValues,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RangeSelector(
      initialRangeValues: _values,
      values: context.watch<Filter>().rangeValues,
      onChanged: (newValues) {
        context.read<Filter>().setRangeValues(newValues);
      },
    );
  }
}

class _FilterShowResultButton extends StatelessWidget {
  const _FilterShowResultButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Sight> sights = _getMatchedResults(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 44, left: 16, right: 16, top: 8),
      child: ElevatedButton(
        onPressed: () {
          print("Filter show button clicked. Data saved");
          context.read<Filter>().setNearbyPlaces(sights);
        },
        child: Text(
          "${AppStrings.filterScreenFilterShow} ${"(${sights.length})"}",
        ),
      ),
    );
  }
}

class FilterRowGroup extends StatelessWidget {
  final Widget child;
  final Text title;
  final Text titleAfter;

  const FilterRowGroup({
    Key? key,
    required Widget this.child,
    required Text this.title,
    Text this.titleAfter = const Text(""),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
            children: [
              _BuildFilterCategoryTitle(
                title: title,
                titleAfter: titleAfter,
              ),
              child,
            ],
          ),
        ],
      ),
    );
  }
}

List<Sight> _getMatchedResults(BuildContext context) {
  // Moscow standard coordinates
  // https://www.latlong.net/place/red-square-moscow-russia-90.html
  final Coordinates _coordinates = Coordinates(55.754093, 37.620407);
  final filterController = context.watch<Filter>();

  final nearbyPlaces = mocks.where((sight) {
    return isPointInBetween(
          Coordinates(sight.lat, sight.lon),
          _coordinates,
          filterController.rangeValues.start,
          filterController.rangeValues.end,
        ) &&
        filterController.selectedCategories.contains(sight.type);
  }).toList();

  // Outputs only if nearby places are in the area
  if (nearbyPlaces.length > 0) {
    print(
      "\n${nearbyPlaces.map((e) => e.toString())}",
    );
  }

  return nearbyPlaces;
}
