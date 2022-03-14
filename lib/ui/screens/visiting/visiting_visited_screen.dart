import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/card/visiting_card.dart';

import '../../components/empty_list.dart';

class VisitingVisitedScreen extends StatelessWidget {
  const VisitingVisitedScreen({Key? key}) : super(key: key);

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
                    Button.icon(
                      icon: AppIcons.share,
                      iconColor: Colors.white,
                      background: Colors.transparent,
                      onPressed: () {
                        print("Share icon clicked");
                      },
                    ),
                    Button.icon(
                      icon: AppIcons.close,
                      iconColor: Colors.white,
                      background: Colors.transparent,
                      onPressed: () {
                        print("Close icon clicked");
                      },
                    ),
                  ],
                  isVisited: true,
                  scheduledAt: 'Цель достигнута 12 окт. 2020',
                  workingStatus: 'закрыто до 09:00',
                ),
            ]),
          )
        : EmptyList(
            iconName: AppIcons.go,
            title: AppStrings.visitingEmpty,
            subtitle: AppStrings.visitingVisitedEmpty,
          );

    return content;
  }
}
