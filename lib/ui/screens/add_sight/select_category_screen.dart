import 'package:flutter/material.dart';
import 'package:places/controllers/add_sight_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:provider/provider.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({Key? key}) : super(key: key);

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  late final TextEditingController selectedCategory;

  @override
  void initState() {
    super.initState();

    selectedCategory =
        TextEditingController(text: context.read<AddSight>().category.value);
    // to update the root value
    selectedCategory.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print(selectedCategory.text);

    return Scaffold(
      appBar: CustomAppBar(
        leading: BackButton(color: theme.textTheme.bodyText2!.color),
        title: Text(AppStrings.addSightScreenCategoryTitle),
      ),
      body: _CategoriesTable(selectedCategory: selectedCategory),
      bottomNavigationBar:
          _SightCategorySelectButton(selectedCategory: selectedCategory),
    );
  }
}

class _CategoriesTable extends StatefulWidget {
  final TextEditingController selectedCategory;

  const _CategoriesTable({
    Key? key,
    required TextEditingController this.selectedCategory,
  }) : super(key: key);

  @override
  State<_CategoriesTable> createState() => _CategoriesTableState();
}

class _CategoriesTableState extends State<_CategoriesTable> {
  @override
  Widget build(BuildContext context) {
    final checkColor = Theme.of(context).primaryColor;

    return ListView.builder(
      itemCount: filterCategories.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            ListTile(
              trailing: filterCategories[index] == widget.selectedCategory.text
                  ? Icon(
                      Icons.check,
                      color: checkColor,
                    )
                  : null,
              onTap: () {
                setState(() {
                  widget.selectedCategory.text = filterCategories[index];
                });
              },
              title: Text(filterCategories[index]),
            ),
            const HorizontalDivider(),
          ],
        );
      },
    );
  }
}

class _SightCategorySelectButton extends StatelessWidget {
  final TextEditingController selectedCategory;

  const _SightCategorySelectButton({
    Key? key,
    required TextEditingController this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDisabled = !(selectedCategory.text.length > 0);
    // print("selected: $selectedCategory");

    return Padding(
      padding: const EdgeInsets.only(bottom: 44, left: 16, right: 16, top: 8),
      child: Button(
        text: AppStrings.addSightScreenSightSave.toUpperCase(),
        onPressed: isDisabled
            ? null
            : () {
                context
                    .read<AddSight>()
                    .validateCategory(selectedCategory.text);
                Navigator.of(context).pop();
              },
        buttonPadding: ButtonPadding.UltraWide,
      ),
    );
  }
}
