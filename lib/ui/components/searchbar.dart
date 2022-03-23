import 'package:flutter/material.dart';
import 'package:places/ui/components/search_field.dart';

class SearchBar extends StatelessWidget {
  final bool readOnly;
  final bool autofocus;
  final void Function()? onTap;
  final void Function()? onEditingComplete;
  final void Function(String? value)? onChange;
  final Widget? suffix;
  final TextEditingController? controller;

  const SearchBar({
    Key? key,
    bool this.readOnly = true,
    bool this.autofocus = true,
    void Function()? this.onTap,
    void Function()? this.onEditingComplete,
    void Function(String? value)? this.onChange,
    Widget? this.suffix,
    TextEditingController? this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SearchField(
        controller: controller,
        autofocus: autofocus,
        readOnly: readOnly,
        onTap: onTap,
        onEditingComplete: onEditingComplete,
        onChange: onChange,
        suffix: suffix,
      ),
    );
  }
}
