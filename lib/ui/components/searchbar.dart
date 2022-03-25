import 'package:flutter/material.dart';
import 'package:places/ui/components/search_field.dart';

class SearchBar extends StatelessWidget {
  final bool readOnly;
  final bool autofocus;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChange;
  final Widget? suffix;
  final TextEditingController? controller;

  const SearchBar({
    Key? key,
    bool this.readOnly = true,
    bool this.autofocus = true,
    VoidCallback? this.onTap,
    VoidCallback? this.onEditingComplete,
    ValueChanged<String>? this.onChange,
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
