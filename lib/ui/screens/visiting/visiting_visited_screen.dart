import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/card/visiting_card.dart';
import 'package:places/ui/components/icon_box.dart';

import '../../../mocks.dart';

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
                    IconContainer(icon: AppIcons.share),
                    IconContainer(icon: AppIcons.close),
                  ],
                  isVisited: true,
                  scheduledAt: 'Цель достигнута 12 окт. 2020',
                  workingStatus: 'закрыто до 09:00',
                ),
            ]),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.7,
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Column(
                    children: [
                      IconContainer(
                        icon: AppIcons.go,
                        color: AppColors.textLabelSecondary,
                        width: 64,
                        height: 64,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Text(
                          AppStrings.visitingEmpty,
                          style: TextStyle(
                            color: AppColors.textLabelSecondary,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          AppStrings.visitingVisitedEmpty,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textLabelSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );

    return content;
  }
}
