import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/models/filter_option.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/icon_box.dart';

class FilterButton extends StatefulWidget {
  /// Creates icon with text that are Column aligned.
  ///
  /// Icon (canvas color) on background (canvas color with 0.4 opacity).
  /// [category] used for label and [icon] selection.
  const FilterButton({
    Key? key,
    required this.category,
    required this.onTap,
  }) : super(key: key);

  final FilterOption category;
  final VoidCallback onTap;

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.category.isSelected;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        widget.onTap();
        setState(() {});
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.canvasColor,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IconBox(
                    icon: _getCategoryIcon(widget.category.engName),
                    color: theme.cardColor,
                    size: 32,
                  ),
                ),
              ),
              if (isSelected) _SelectedBadge(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              _useShortName(widget.category.name),
              style: theme.textTheme.caption!.copyWith(
                color: theme.textTheme.bodyText2!.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Shortens the content of a long string.
  String _useShortName(String name) {
    if (name.split(" ").length > 1) {
      final result = [];
      for (var word in name.split(" ")) {
        result.add(word.length > 8 ? "${word.substring(0, 4)}." : word);
      }

      return result.join(" ");
    }

    return name.length > 15
        ? "${name.substring(0, 5)}-${name.substring(name.length - 4, name.length)}"
        : name;
  }

  /// Returns relevant icon for [category]. If [category] is not found,
  /// returns [AppIcons.error].
  ///
  /// TMP!
  String _getCategoryIcon(String category) {
    // log('_getCategoryIcon: $category');
    if (category == SightCategories.hotel.engName) {
      return AppIcons.hotel;
    }
    if (category == SightCategories.restaurant.engName) {
      return AppIcons.restaurant;
    }
    if (category == SightCategories.museum.engName) {
      return AppIcons.museum;
    }
    if (category == SightCategories.park.engName) {
      return AppIcons.park;
    }
    if (category == SightCategories.cafe.engName) {
      return AppIcons.cafe;
    }
    if (category == SightCategories.poi.engName) {
      return AppIcons.poi;
    }

    return AppIcons.error;
  }
}

/// Check icon for selected [FilterButton]
class _SelectedBadge extends StatelessWidget {
  const _SelectedBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Icon(
      Icons.check_circle,
      size: 16,
      color: theme.textTheme.bodyText2!.color,
    );
  }
}
