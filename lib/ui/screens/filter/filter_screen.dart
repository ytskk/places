import 'package:flutter/material.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/models/coordinates.dart';
import 'package:places/models/filter_option.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/filter_button.dart';
import 'package:places/ui/components/range_selector.dart';
import 'package:places/ui/components/row_group.dart';
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowGroup(
              title: Text(AppStrings.filterScreenFilterTitle.toUpperCase()),
              child: _FilterButtonsTable(),
            ),
            RowGroup(
              title: Text(
                AppStrings.filterScreenRangeSelectionGroupTitle,
                style: bodyText2,
              ),
              titleAfter: Text(
                getRangeValuesString(context.watch<Filter>().rangeValues),
                style: TextStyle(fontSize: 16),
              ),
              child: RangeSelector(
                rangeValues: RangeValues(100, 10000),
                values: context.watch<Filter>().rangeValues,
                onChanged: (newValues) {
                  context.read<Filter>().setRangeValues(newValues);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _FilterShowResultButton(),
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

    final List<Widget> categoriesButtons = categories
        .map((category) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilterButton(
                category: category,
                onTap: () {
                  context.read<Filter>().toggleCategory(category);
                },
              ),
            ))
        .toList();

    return Wrap(
      children: categoriesButtons,
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
          print("Founded $sights");
        },
        child: Text(
          "${AppStrings.filterScreenFilterShow} ${"(${sights.length})"}",
        ),
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
