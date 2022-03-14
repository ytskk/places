import 'package:flutter/material.dart';
import 'package:places/controllers/filter_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/sight.dart';
import 'package:places/models/filter_option.dart';
import 'package:places/ui/components/icon_box.dart';
import 'package:provider/provider.dart';

class FilterButton extends StatefulWidget {
  final FilterOption category;
  final Function() onTap;

  const FilterButton({
    Key? key,
    required FilterOption this.category,
    required this.onTap,
  }) : super(key: key);

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
        context.read<Filter>().toggleCategory(widget.category);
        setState(() {});
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: isSelected
                      ? theme.canvasColor
                      : theme.canvasColor.withAlpha(40),
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IconBox(
                    icon: _getCategoryIcon(widget.category.name),
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
              style: theme.textTheme.caption,
            ),
          ),
        ],
      ),
    );
  }

  /**
 * Shortens the content of a long string.
 */
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

  String _getCategoryIcon(String category) {
    switch (category) {
      case SightCategories.coffeeShop:
        return AppIcons.coffee;
      case SightCategories.historicalBuilding:
        return AppIcons.tour;
      case SightCategories.shoppingCentre:
        return AppIcons.shoppingBag;
      case SightCategories.sightseeing:
        return AppIcons.map_fill;
      case SightCategories.hotel:
        return AppIcons.hotel;
      case SightCategories.restaurant:
        return AppIcons.restaurant;
      case SightCategories.park:
        return AppIcons.park;
      case SightCategories.museum:
        return AppIcons.museum;
      case SightCategories.cafe:
        return AppIcons.cafe;
      case SightCategories.poi:
        return AppIcons.poi;
      default:
        return AppIcons.error;
    }
  }
}

class _SelectedBadge extends StatelessWidget {
  const _SelectedBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.dialogBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: IconBox(
          icon: AppIcons.check,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }
}
