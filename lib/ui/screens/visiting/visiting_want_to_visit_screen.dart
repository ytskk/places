import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/card/visiting_card.dart';
import 'package:places/ui/components/empty_list.dart';
import 'package:places/ui/components/icon_box.dart';

class VisitingWantToVisitScreen extends StatelessWidget {
  const VisitingWantToVisitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var li = mocks;
    var content;

    content = li.isNotEmpty
        ? SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(children: [
              for (var sight in li)
                VisitingCard(
                  sight,
                  actions: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        print("Calendar icon clicked");
                      },
                      icon: IconBox(icon: AppIcons.calendar),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        print("Close icon clicked");
                      },
                      icon: IconBox(icon: AppIcons.close),
                    ),
                  ],
                  isVisited: false,
                  scheduledAt: 'Запланировано на 12 окт. 2020',
                  workingStatus: 'закрыто до 09:00',
                ),
            ]),
          )
        : EmptyList(
            iconName: AppIcons.card,
            title: AppStrings.visitingEmpty,
            subtitle: AppStrings.visitingWantToVisitEmpty,
          );

    return content;
  }
}
