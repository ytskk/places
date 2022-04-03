import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/controllers/add_sight_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/models/dialog.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/custom_text_field.dart';
import 'package:places/ui/components/dialog/dialog.dart';
import 'package:places/ui/components/rounded_box.dart';
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
            showAlertDialog(
              context,
              const _AddSightCloseButtonDialog(),
            );
          },
        ),
        title: const Text(AppStrings.addSightScreenAppTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // platform specified scroll physics
          physics: Platform.isIOS || Platform.isMacOS
              ? const BouncingScrollPhysics()
              : const ClampingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _CategoryPhotoLoader(),
                const _CategorySelection(),
                const _SightName(),
                _SightCoordinates(nextFocus: _sightDescriptionNode),
                const _ShowOnMap(),
                _SightDescription(focusNode: _sightDescriptionNode),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _SightCreateButton(),
    );
  }
}

/// Creates photo loader component.
///
/// First element is [_AddSightImageButton] and all others are [_AddSightAddedImageItem].
class _CategoryPhotoLoader extends StatelessWidget {
  const _CategoryPhotoLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final images = context.watch<AddSight>().images;

    return SizedBox(
      height: 72,
      width: double.infinity,
      child: ListView.builder(
        // platform specified scroll physics
        physics: Platform.isIOS || Platform.isMacOS
            ? const BouncingScrollPhysics()
            : const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: images.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _AddSightImageButton();
          }

          final image = images[index - 1];

          return Padding(
            padding: const EdgeInsets.only(left: 16),
            child: _AddSightAddedImageItem(
              element: image,
            ),
          );
        },
      ),
    );
  }
}

/// Creates readOnly [TextField] with on pressed callback to navigate to [SelectCategoryScreen].
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
            MaterialPageRoute(
              builder: (context) => const SelectCategoryScreen(),
            ),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ),
        ),
        const SizedBox(width: 16),
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
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
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
        style: const TextStyle(fontWeight: FontWeight.w500),
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

/// Button is enabled when [AddSight.validateFields] is true.
class _SightCreateButton extends StatelessWidget {
  const _SightCreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 44, left: 16, right: 16, top: 8),
      child: Button(
        text: AppStrings.addSightScreenSightCreate.toUpperCase(),
        onPressed: context.watch<AddSight>().validateFields()
            ? () {
                showAlertDialog(
                  context,
                  const _AddSightCreateButtonDialog(),
                );
              }
            : null,
        buttonPadding: ButtonPadding.UltraWide,
      ),
    );
  }
}

/// Dialog, preventing form values loss.
class _AddSightCloseButtonDialog extends StatelessWidget {
  const _AddSightCloseButtonDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      dialogState: DialogState.Alert,
      content: Text(
        AppStrings.addSightScreenSightDialogCloseContent,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.read<AddSight>().clearFields();
            Navigator.of(context)
              ..pop()
              ..pop();
          },
          child: Text(AppStrings.addSightScreenSightDialogCloseActionClose),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(AppStrings.addSightScreenSightDialogCloseActionStay),
        ),
      ],
    );
  }
}

class _AddSightCreateButtonDialog extends StatelessWidget {
  const _AddSightCreateButtonDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      content: Text(
        AppStrings.addSightScreenSightDialogCreateContent,
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () {
            mocks.add(context.read<AddSight>().createSight());
            context.read<AddSight>().clearFields();
            Navigator.of(context)
              ..pop()
              ..pop();
          },
          child: Text(
            AppStrings.addSightScreenSightDialogCreateActionTitle,
          ),
        ),
      ],
    );
  }
}

/// Zero element to choose new photo.
///
/// Bordered centered plus icon.
///
/// TODO: implement image picker!
class _AddSightImageButton extends StatelessWidget {
  const _AddSightImageButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).primaryColor.withOpacity(0.48);

    return Center(
      child: InkWell(
        onTap: () {
          // temp!
          showAlertDialog(
            context,
            DialogWidget(
              content: Text(
                'Image picker',
                textAlign: TextAlign.center,
              ),
              dialogState: DialogState.Alert,
              actions: [
                TextButton(
                  onPressed: () {
                    context.read<AddSight>().addImage();
                    Navigator.of(context).pop();
                  },
                  child: Text('Add image'),
                ),
              ],
            ),
          );
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: accentColor,
              width: 2,
            ),
          ),
          child: SizedBox(
            height: 72,
            width: 72,
            child: Center(
              child: Icon(
                Icons.add_rounded,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Represents loaded image item.
class _AddSightAddedImageItem extends StatelessWidget {
  /// [element] — temporary argument, represents image data.
  ///
  /// Data stored in [AddSight._sightImages].
  const _AddSightAddedImageItem({
    Key? key,
    this.element,
  }) : super(key: key);

  final element;

  @override
  Widget build(BuildContext context) {
    final arrowUpIconColor = Theme.of(context).textTheme.bodyText2!.color;

    return Dismissible(
      key: ValueKey(element),
      background: Align(
        child: Icon(
          Icons.keyboard_arrow_up_rounded,
          color: arrowUpIconColor,
        ),
        alignment: Alignment.bottomCenter,
      ),
      direction: DismissDirection.up,
      onDismissed: (DismissDirection data) {
        context.read<AddSight>().removeImage(element);
      },
      child: RoundedBox(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            // mock image
            const SizedBox(
              height: 72,
              width: 72,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                ),
              ),
            ),
            const Opacity(
              opacity: 0.24,
              child: SizedBox(
                height: 72,
                width: 72,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<AddSight>().removeImage(element);
              },
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    CupertinoIcons.clear_circled_solid,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
