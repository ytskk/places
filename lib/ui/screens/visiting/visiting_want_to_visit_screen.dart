import 'package:flutter/material.dart';
import 'package:places/domain/app_colors.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/icon_container.dart';
import 'package:places/ui/components/visiting_card.dart';

class VisitingWantToVisitScreen extends StatelessWidget {
  const VisitingWantToVisitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var li = [];
    var content;

    content = li.isNotEmpty
        ? SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(children: [
              for (var sight in li)
                VisitingCard(
                  sight,
                  actions: [
                    IconContainer(icon: AppIcons.calendar),
                    IconContainer(icon: AppIcons.close),
                  ],
                  isVisited: false,
                  scheduledAt: 'Запланировано на 12 окт. 2020',
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
                        icon: AppIcons.card,
                        color: AppColors.whiteInactiveBlack,
                        width: 64,
                        height: 64,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Text(
                          AppStrings.visitingEmpty,
                          style: TextStyle(
                            color: AppColors.whiteInactiveBlack,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          AppStrings.visitingWantToVisitEmpty,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.whiteInactiveBlack,
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
