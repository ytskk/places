import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/controllers/add_sight_controller.dart';
import 'package:places/domain/app_strings.dart';
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

  late final FocusNode _sightCoordinatesNode;
  late final FocusNode _sightDescriptionNode;

  @override
  void initState() {
    super.initState();

    _sightCoordinatesNode = FocusNode();
    _sightDescriptionNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Button(
          background: Colors.transparent,
          text: AppStrings.addSightScreenAppLeading,
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
                _SightName(nextFocus: _sightCoordinatesNode),
                _SightCoordinates(
                  focusNode: _sightCoordinatesNode,
                  nextNode: _sightDescriptionNode,
                ),
                _ShowOnMap(),
                _SightDescription(focusNode: _sightDescriptionNode),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _SightCreateButton(formKey: _formKey),
    );
  }
}

class _CategorySelection extends StatelessWidget {
  const _CategorySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryController =
        TextEditingController(text: context.watch<AddSight>().category);

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
  final FocusNode nextFocus;

  const _SightName({Key? key, required FocusNode this.nextFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RowGroup(
      title: Text(AppStrings.addSightScreenSightNameTitle.toUpperCase()),
      child: CustomTextField(
        onChanged: (value) {
          context.read<AddSight>().setName(value);
        },
        onEditingComplete: () {
          nextFocus.requestFocus();
        },
      ),
    );
  }
}

class _SightCoordinates extends StatefulWidget {
  final FocusNode focusNode;
  final FocusNode nextNode;

  const _SightCoordinates({
    Key? key,
    required FocusNode this.focusNode,
    required FocusNode this.nextNode,
  }) : super(key: key);

  @override
  State<_SightCoordinates> createState() => _SightCoordinatesState();
}

class _SightCoordinatesState extends State<_SightCoordinates> {
  final FocusNode _sightCoordinatesLonNode = FocusNode();

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
                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
              ],
              onChanged: (value) {
                context
                    .read<AddSight>()
                    .setCoordinatesLat(double.tryParse(value) ?? 0.0);
              },
              focusNode: widget.focusNode,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onEditingComplete: () {
                _sightCoordinatesLonNode.requestFocus();
              },
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
                FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)')),
              ],
              onChanged: (value) {
                context
                    .read<AddSight>()
                    .setCoordinatesLon(double.tryParse(value) ?? 0.0);
                print("coord: ${double.tryParse(value)}");
              },
              focusNode: _sightCoordinatesLonNode,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onEditingComplete: () {
                widget.nextNode.requestFocus();
              },
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
        onChanged: (value) {
          context.read<AddSight>().setDescription(value);
        },
        focusNode: focusNode,
        hint: AppStrings.addSightScreenSightDescriptionHint,
        maxLines: 3,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}

class _SightCreateButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _SightCreateButton({
    Key? key,
    required GlobalKey<FormState> this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDisabled = !context
        .watch<AddSight>()
        .validateFields()
        .every((el) => el.toString().length > 0);
    // print(isDisabled);

    return Padding(
      padding: const EdgeInsets.only(bottom: 44, left: 16, right: 16, top: 8),
      child: Button(
        text: AppStrings.addSightScreenSightCreate.toUpperCase(),
        onPressed: isDisabled ? null : () {},
        buttonPadding: ButtonPadding.UltraWide,
      ),
    );
  }
}
