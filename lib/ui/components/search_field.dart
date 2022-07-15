import 'package:flutter/material.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/icon_box.dart';

/// Custom search field, based on [TextField].
class SearchField extends StatefulWidget {
  /// Creates search text field.
  ///
  /// Search icon in [prefix].
  ///
  /// Field may be read only with [onTap] callback.
  const SearchField({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.autofocus = false,
    this.onTap,
    this.onEditingComplete,
    this.suffix,
    this.onChange,
    this.focusNode,
  }) : super(key: key);

  /// Controls the text being edited.
  ///
  /// If null, this widget will create it's own [TextEditingController].
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool autofocus;
  final VoidCallback? onTap;

  /// Optional widget to place on the line after the input.
  final Widget? suffix;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChange;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onTap: widget.onTap,
      onChanged: widget.onChange,
      onEditingComplete: () {
        if (widget.onEditingComplete != null) {
          widget.onEditingComplete!.call();
        }
        _focusNode.unfocus();
      },
      textInputAction: TextInputAction.search,
      readOnly: widget.readOnly,
      autofocus: widget.autofocus,
      style: textTheme.bodyText2,
      decoration: InputDecoration(
        filled: true,
        hintText: AppStrings.searchFieldHint,
        hintStyle: textTheme.bodyText1,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              const BorderRadius.all(Radius.circular(smallBorderRadius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius:
              const BorderRadius.all(Radius.circular(smallBorderRadius)),
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: IconBox(
            icon: AppIcons.search,
            color: textTheme.bodyText1!.color,
          ),
        ),
        suffixIcon: widget.suffix,
      ),
    );
  }
}
