import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/controllers/settings_controller.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/screens/res/themes.dart';
import 'package:provider/provider.dart';

/// Creates custom text field according to the design.
class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    this.focusNode,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.maxLines = 1,
    this.hint,
  }) : super(key: key);

  final FocusNode? focusNode;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create it's own [TextEditingController].
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final int? maxLines;
  final String? hint;
  final ValueSetter<String>? onFieldSubmitted;
  final FormFieldValidator? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;
  late final ValueChanged<String>? _onChanged;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _onChanged = widget.onChanged ?? (value) {};

    // to handle clear button visibility
    _focusNode.addListener(() => setState(() {}));
    // print('focus node built: ${_focusNode}');
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    _focusNode.dispose();
    // print('focus node disposed: ${_focusNode}');
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).textTheme.bodyText2!.color;
    final theme = Theme.of(context);

    return TextFormField(
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      controller: _controller,
      cursorColor: cursorColor,
      style: theme.textTheme.bodyText2,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: theme.textTheme.bodyText1,
        suffixIcon: _focusNode.hasFocus
            ? ClearButton(
                controller: _controller,
                onChanged: _onChanged,
              )
            : null,
      ),
    );
  }
}

class ClearButton extends StatelessWidget {
  final TextEditingController controller;

  final void Function(String value)? onChanged;

  const ClearButton({
    Key? key,
    required TextEditingController this.controller,
    void Function(String value)? this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).textTheme.bodyText2!.color;

    return InkWell(
      onTap: () {
        controller.clear();
        print("cleared ${controller.text}");

        if (onChanged != null) {
          onChanged!(controller.text);
        }
      },
      child: Icon(
        CupertinoIcons.clear_circled_solid,
        color: iconColor,
      ),
    );
  }
}

class UnderlinedTextField extends StatefulWidget {
  final TextEditingController controller;
  final void Function()? onTap;

  const UnderlinedTextField({
    Key? key,
    required TextEditingController this.controller,
    void Function()? this.onTap,
  }) : super(key: key);

  @override
  State<UnderlinedTextField> createState() => _UnderlinedTextFieldState();
}

class _UnderlinedTextFieldState extends State<UnderlinedTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      readOnly: true,
      onTap: widget.onTap,
      style: theme.textTheme.bodyText2,
      controller: widget.controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: theme.textTheme.bodyText1!.color!,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: theme.textTheme.bodyText1!.color!,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppThemeData.selectColor(
              isDark: context.read<Settings>().isDarkTheme,
            ).red,
          ),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppThemeData.selectColor(
              isDark: context.read<Settings>().isDarkTheme,
            ).red,
          ),
        ),
        suffixIcon: Icon(
          CupertinoIcons.chevron_forward,
          color: theme.textTheme.bodyText2!.color,
        ),
        hintText: AppStrings.addSightScreenCategoryLabel,
        hintStyle: theme.textTheme.bodyText1,
      ),
    );
  }
}
