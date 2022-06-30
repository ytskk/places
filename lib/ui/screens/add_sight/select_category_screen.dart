import 'package:flutter/material.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/horizontal_divider.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({
    Key? key,
    required this.selectedCategory,
  }) : super(key: key);

  final PlaceCategory? selectedCategory;

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  late PlaceCategory? selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        leading: BackButton(color: theme.textTheme.bodyText2!.color),
        title: Text(AppStrings.addSightScreenCategoryTitle),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _CategoriesTable(
              selectedCategory: widget.selectedCategory,
              onCategoryTap: (PlaceCategory newCategory) {
                setState(() {
                  selectedCategory = newCategory;
                });
              },
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: true,
              child: _SightCategorySelectButton(
                selectedCategory: selectedCategory,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesTable extends StatefulWidget {
  const _CategoriesTable({
    Key? key,
    required this.selectedCategory,
    required this.onCategoryTap,
  }) : super(key: key);

  final PlaceCategory? selectedCategory;
  final Function(PlaceCategory newValue) onCategoryTap;

  @override
  State<_CategoriesTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState extends State<_CategoriesTable> {
  late PlaceCategory? selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory = widget.selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    final checkColor = Theme.of(context).primaryColor;

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            children: [
              ListTile(
                trailing: filterCategories[index] == selectedCategory
                    ? Icon(
                        Icons.check,
                        color: checkColor,
                      )
                    : null,
                onTap: () {
                  widget.onCategoryTap(filterCategories[index]);
                  setState(() {
                    selectedCategory = filterCategories[index];
                  });
                },
                title: Text(filterCategories[index].name),
              ),
              const HorizontalDivider(),
            ],
          );
        },
        childCount: filterCategories.length,
      ),
    );
  }
}

class _SightCategorySelectButton extends StatelessWidget {
  const _SightCategorySelectButton({
    Key? key,
    required this.selectedCategory,
  }) : super(key: key);

  final PlaceCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    bool isDisabled = selectedCategory == null;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Button(
            text: AppStrings.addSightScreenSightSave.toUpperCase(),
            onPressed: isDisabled
                ? null
                : () {
                    Navigator.of(context).pop(selectedCategory);
                  },
            buttonPadding: ButtonPadding.UltraWide,
          ),
        ),
      ),
    );
  }
}
