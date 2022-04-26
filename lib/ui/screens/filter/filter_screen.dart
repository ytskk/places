import 'package:flutter/material.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/models/coordinates.dart';
import 'package:places/models/filter_option.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/filter_button.dart';
import 'package:places/ui/components/range_selector.dart';
import 'package:places/utils/coordinates.dart';
import 'package:places/utils/screen_sizes.dart';
import 'package:places/utils/string_manipulations.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    final categories = context.read<Filter>().filterOptions;

    return Scaffold(
      appBar: CustomAppBar(
        leading: BackButton(
          color: bodyText2!.color,
        ),
        actions: [
          TextButton(
            onPressed: () {
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
            _FilterButtonsTable(
              categories: categories,
            ),
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
                rangeValues: RangeValues(
                  context.read<Filter>().initialRangeValueStart,
                  context.read<Filter>().initialRangeValueEnd,
                ),
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: _FilterShowResultButton(),
            ),
          ],
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
    final titleTextTheme = Theme.of(context).textTheme.bodyText1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title.data!,
            style: titleTextTheme!
                .copyWith(
                  fontSize: 12,
                  color: titleTextTheme.color!.withOpacity(0.56),
                )
                .merge(title.style),
          ),
          if (titleAfter.data!.length > 0)
            Text(
              titleAfter.data!,
              style: titleTextTheme
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

/// Returns [FilterOption] buttons, depends on screen height.
///
/// If screen height is less than [_screenSizeSmall], returns [_FilterButtonsTableSmall].
class _FilterButtonsTable extends StatelessWidget {
  _FilterButtonsTable({
    Key? key,
    required this.categories,
  }) : super(key: key);

  late final ScreenSizes screenSize;
  final List<FilterOption> categories;

  @override
  Widget build(BuildContext context) {
    final screenSize =
        resolveScreenHeightSize(MediaQuery.of(context).size.height);

    switch (screenSize) {
      case ScreenSizes.Small:
        return _FilterButtonsTableSmall(
          content: categories,
        );
      default:
        return _FilterButtonsTableMedium(
          content: categories,
        );
    }
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
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(smallSpacing),
            child: FilterButton(
              category: content.elementAt(index),
              onTap: () {
                context.read<Filter>().toggleCategory(content[index]);
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
                  context.read<Filter>().toggleCategory(content[index]);
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

class _RangeSelection extends StatefulWidget {
  _RangeSelection({
    Key? key,
    required RangeValues rangeValues,
  })  : _values = rangeValues,
        super(key: key);

  final RangeValues _values;

  @override
  State<_RangeSelection> createState() => _RangeSelectionState();
}

class _RangeSelectionState extends State<_RangeSelection> {
  @override
  Widget build(BuildContext context) {
    return RangeSelector(
      initialRangeValues: widget._values,
      values: context.watch<Filter>().rangeValues,
      onChanged: (newValues) {
        context.read<Filter>().setRangeValues(newValues);
      },
    );
  }
}

class _FilterShowResultButton extends StatefulWidget {
  const _FilterShowResultButton({Key? key}) : super(key: key);

  @override
  State<_FilterShowResultButton> createState() =>
      _FilterShowResultButtonState();
}

class _FilterShowResultButtonState extends State<_FilterShowResultButton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: FutureBuilder(
            future: context.watch<Filter>().parseFilteredPlaces(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Text('Has an error: ${snapshot.error}');
              }

              bool isLoaded = snapshot.connectionState == ConnectionState.done;
              List<Place> candidates = isLoaded ? snapshot.data : [];

              return ElevatedButton(
                onPressed: isLoaded && candidates.isNotEmpty
                    ? () {
                        Navigator.of(context).pop();
                        context.read<Filter>().setFilteredPlaces(candidates);
                      }
                    : null,
                child: Text(
                  isLoaded
                      ? '${AppStrings.filterScreenFilterShow} ${candidates.length}'
                      : 'Загрузка...',
                ),
              );
            },
          ),
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
