import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/controllers/add_sight_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/custom_text_field.dart';
import 'package:places/ui/components/row_group.dart';
import 'package:places/ui/screens/add_sight/select_category_screen.dart';
import 'package:provider/provider.dart';

class AddSightScreen extends StatefulWidget {
  const AddSightScreen({Key? key}) : super(key: key);

  @override
  State<AddSightScreen> createState() => _AddSightScreenState();
}

class _AddSightScreenState extends State<AddSightScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final FocusNode _sightDescriptionNode;

  @override
  void initState() {
    super.initState();

    _sightDescriptionNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Button(
          background: Colors.transparent,
          text: AppStrings.addSightScreenAppLeading,
          onPressed: () {
            context.read<AddSight>().clearFields();
            Navigator.pop(context);
          },
        ),
        title: Text(AppStrings.addSightScreenAppTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CategorySelection(),
                _SightName(),
                _SightCoordinates(nextFocus: _sightDescriptionNode),
                _ShowOnMap(),
                _SightDescription(focusNode: _sightDescriptionNode),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _SightCreateButton(),
    );
  }
}

class _CategorySelection extends StatelessWidget {
  const _CategorySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryController =
        TextEditingController(text: context.watch<AddSight>().category.value);

    return RowGroup(
      title: Text(AppStrings.addSightScreenCategoryTitle.toUpperCase()),
      child: UnderlinedTextField(
        controller: categoryController,
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => SelectCategoryScreen()),
          );
        },
      ),
    );
  }
}

class _SightName extends StatelessWidget {
  const _SightName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowGroup(
      title: Text(AppStrings.addSightScreenSightNameTitle.toUpperCase()),
      child: CustomTextField(
        onChanged: (value) {
          context.read<AddSight>().validateName(value);
        },
        validator: (value) => context.read<AddSight>().name.error,
        onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      ),
    );
  }
}

class _SightCoordinates extends StatefulWidget {
  final FocusNode nextFocus;

  const _SightCoordinates({Key? key, required FocusNode this.nextFocus})
      : super(key: key);

  @override
  State<_SightCoordinates> createState() => _SightCoordinatesState();
}

class _SightCoordinatesState extends State<_SightCoordinates> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RowGroup(
            title: Text(
              AppStrings.addSightScreenSightCoordinatesLat.toUpperCase(),
            ),
            child: CustomTextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(FieldsPatterns.doublePattern),
              ],
              onChanged: (value) =>
                  context.read<AddSight>().validateCoordinatesLat(value),
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: RowGroup(
            title: Text(
              AppStrings.addSightScreenSightCoordinatesLon.toUpperCase(),
            ),
            child: CustomTextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(FieldsPatterns.doublePattern),
              ],
              onChanged: (value) =>
                  context.read<AddSight>().validateCoordinatesLon(value),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(widget.nextFocus),
            ),
          ),
        ),
      ],
    );
  }
}

class _ShowOnMap extends StatelessWidget {
  const _ShowOnMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.zero),
      ),
      onPressed: () {},
      child: Text(
        AppStrings.addSightScreenSightShowOnMap,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _SightDescription extends StatelessWidget {
  final FocusNode focusNode;

  const _SightDescription({
    Key? key,
    required FocusNode this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowGroup(
      title: Text(AppStrings.addSightScreenSightDescription.toUpperCase()),
      child: CustomTextField(
        onChanged: (value) =>
            context.read<AddSight>().validateDescription(value),
        focusNode: focusNode,
        hint: AppStrings.addSightScreenSightDescriptionHint,
        maxLines: 3,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}

class _SightCreateButton extends StatelessWidget {
  const _SightCreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 44, left: 16, right: 16, top: 8),
      child: Button(
        text: AppStrings.addSightScreenSightCreate.toUpperCase(),
        // onPressed: isDisabled ? null : () {},
        onPressed: context.watch<AddSight>().validateFields()
            ? () {
          mocks.add(context.read<AddSight>().createSight());
                context.read<AddSight>().clearFields();
                Navigator.pop(context);
              }
            : null,
        buttonPadding: ButtonPadding.UltraWide,
      ),
    );
  }
}
