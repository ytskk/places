import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/icon_box.dart';

class SearchField extends StatefulWidget {
  final bool readOnly;
  final bool autofocus;
  final void Function()? onTap;
  final Widget? suffix;
  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChange;

  const SearchField({
    Key? key,
    bool this.readOnly = false,
    bool this.autofocus = false,
    VoidCallback? this.onTap,
    VoidCallback? this.onEditingComplete,
    Widget? this.suffix,
    TextEditingController? this.controller,
    ValueChanged<String>? this.onChange,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TextField(
      controller: _controller,
      onTap: widget.onTap,
      onChanged: widget.onChange,
      onEditingComplete: widget.onEditingComplete,
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
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
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
