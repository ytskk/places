import 'package:flutter/material.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/card/visiting_card.dart';
import 'package:places/ui/components/icon_box.dart';

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
                    IconBox(icon: AppIcons.share),
                    IconBox(icon: AppIcons.close),
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
