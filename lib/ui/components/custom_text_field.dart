import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:places/domain/app_strings.dart';

class CustomTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  final void Function()? onEditingComplete;
  final void Function(String)? onChanged;
  final int? maxLines;
  final String? hint;

  const CustomTextField({
    Key? key,
    FocusNode? this.focusNode,
    TextEditingController? this.controller,
    TextInputType this.keyboardType = TextInputType.text,
    TextInputAction this.textInputAction = TextInputAction.next,
    List<TextInputFormatter>? this.inputFormatters,
    void Function()? this.onEditingComplete,
    void Function(String)? this.onChanged,
    int? this.maxLines = 1,
    String? this.hint,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  late TextEditingController _controller;
  late void Function(String value) _onChanged;

  @override
  void initState() {
    super.initState();

    _focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
    _onChanged = widget.onChanged ?? (value) {};

    // to handle clear button visibility
    _focusNode.addListener(() => setState(() {}));
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cursorColor = Theme.of(context).textTheme.bodyText2!.color;
    final theme = Theme.of(context);

    return TextFormField(
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      onEditingComplete: widget.onEditingComplete,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      focusNode: _focusNode,
      controller: _controller,
      cursorColor: cursorColor,
      style: theme.textTheme.bodyText2,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: theme.textTheme.bodyText1,
        suffixIcon: _focusNode.hasFocus
            ? _ClearButton(
                controller: _controller,
                onChanged: _onChanged,
              )
            : null,
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  final TextEditingController controller;

  final void Function(String value) onChanged;

  const _ClearButton({
    Key? key,
    required TextEditingController this.controller,
    required void Function(String value) this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).textTheme.bodyText2!.color;

    return InkWell(
      onTap: () {
        controller.clear();
        print("cleared ${controller.text}");
        onChanged(controller.text);
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
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      readOnly: true,
      onTap: widget.onTap,
      style: textTheme.bodyText2,
      controller: widget.controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: textTheme.bodyText1!.color!,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: textTheme.bodyText1!.color!,
          ),
        ),
        suffixIcon: Icon(
          CupertinoIcons.chevron_forward,
          color: textTheme.bodyText2!.color,
        ),
        hintText: AppStrings.addSightScreenCategoryLabel,
        hintStyle: textTheme.bodyText1,
      ),
    );
  }
}
