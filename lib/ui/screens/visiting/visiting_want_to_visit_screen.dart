import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/rounded_box.dart';
import 'package:places/ui/components/visiting/visiting_list_item.dart';
import 'package:provider/provider.dart';

class VisitingWantToVisitScreen extends StatefulWidget {
  const VisitingWantToVisitScreen({Key? key}) : super(key: key);

  @override
  State<VisitingWantToVisitScreen> createState() =>
      _VisitingWantToVisitScreenState();
}

class _VisitingWantToVisitScreenState extends State<VisitingWantToVisitScreen> {
  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText2!.color;
    final List<Sight> wantToVisitPlaces =
        context.watch<VisitingPlaces>().wantToVisitPlaces;

    return wantToVisitPlaces.isNotEmpty
        ? ReorderableListView(
            padding: const EdgeInsets.all(16),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Sight item = wantToVisitPlaces.removeAt(oldIndex);
                wantToVisitPlaces.insert(newIndex, item);
              });
            },
            children: [
              ...wantToVisitPlaces.map(
                (sight) => VisitingListItem(
                  key: ValueKey(sight),
                  sight: sight,
                  cardActions: [
                    Button.icon(
                      icon: AppIcons.calendar,
                      iconColor: Colors.white,
                      background: Colors.transparent,
                      onPressed: () async {
                        // print('for $sight pressed calendar button');
                        DateTime? remindDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 31)),
                          builder: (context, child) => Theme(
                            data: dateTimePickerThemeData(context),
                            child: child!,
                          ),
                        );
                        print(
                            '$sight is planned to visit on ${remindDate?.toIso8601String()}');
                      },
                    ),
                  ],
                  isVisited: true,
                  scheduledAt:
                      '${AppStrings.visitingWantToVisitPlannedAt} 12 окт. 2020',
                  workingStatus:
                      '${AppStrings.visitingVisitedClosedUntil} 09:00',
                  onDeleteButtonPressed: () {
                    context
                        .read<VisitingPlaces>()
                        .deleteWantToVisitPlaceById(sight.id);
                  },
                ),
              ),
            ],
          )
        : Center(
            child: InfoList(
              iconName: AppIcons.card,
              iconColor: textColor,
              title: Text(AppStrings.visitingEmpty),
              subtitle: Text(
                AppStrings.visitingWantToVisitEmpty,
                textAlign: TextAlign.center,
              ),
            ),
          );
  }
}

ThemeData Function(BuildContext context) dateTimePickerThemeData =
    (BuildContext context) {
  final theme = Theme.of(context);

  return ThemeData(
    dialogBackgroundColor: theme.scaffoldBackgroundColor,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(smallBorderRadius),
        ),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: theme.primaryColor,
      onSurface: theme.textTheme.bodyText2!.color!,
    ),
  );
};
