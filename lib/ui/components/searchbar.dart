import 'package:flutter/material.dart';
import 'package:places/ui/components/search_field.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key? key,
    this.readOnly = true,
    this.autofocus = true,
    this.onTap,
    this.onEditingComplete,
    this.onChange,
    this.suffix,
    this.controller,
  }) : super(key: key);

  final bool readOnly;
  final bool autofocus;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChange;
  final Widget? suffix;
  final TextEditingController? controller;

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
