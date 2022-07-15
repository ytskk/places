import 'package:flutter/material.dart';
import 'package:places/ui/components/search_field.dart';

class SearchBar extends StatefulWidget {
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
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
  }

  @override
  dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: SearchField(
        controller: _controller,
        autofocus: widget.autofocus,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        onEditingComplete: widget.onEditingComplete,
        onChange: widget.onChange,
        suffix: widget.suffix,
      ),
    );
  }
}
