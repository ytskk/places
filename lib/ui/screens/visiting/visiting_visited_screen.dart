import 'package:flutter/material.dart';
import 'package:places/controllers/visiting_places_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/button.dart';
import 'package:places/ui/components/visiting/visiting_list_element.dart';
import 'package:provider/provider.dart';

class VisitingVisitedScreen extends StatefulWidget {
  const VisitingVisitedScreen({Key? key}) : super(key: key);

  @override
  State<VisitingVisitedScreen> createState() => _VisitingVisitedScreenState();
}

class _VisitingVisitedScreenState extends State<VisitingVisitedScreen> {
  @override
  Widget build(BuildContext context) {
    final List<Sight> li = context.watch<VisitingPlaces>().visitedPlaces;

    return ListView.builder(
      itemCount: li.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (BuildContext context, int index) => DragTarget<Sight>(
        onWillAccept: (sight) {
          return li.indexOf(sight!) != index;
        },
        onAccept: (sight) {
          setState(() {
            int currentIndex = li.indexOf(sight);
            print('current index: $currentIndex; index: $index');
            int newIndex = index;
            if (currentIndex < index) {
              newIndex -= 1;
            }
            final item = li.removeAt(currentIndex);
            li.insert(newIndex, item);
          });
        },
        builder: (
          BuildContext context,
          List<Object?> candidateData,
          List<dynamic> rejectedData,
        ) {
          return LongPressDraggable(
            data: li[index],
            axis: Axis.vertical,
            feedback: SizedBox.shrink(),
            child: VisitingListElement(
              key: ValueKey(li[index]),
              sight: li[index],
              cardActions: [
                Button.icon(
                  icon: AppIcons.share,
                  iconColor: Colors.white,
                  background: Colors.transparent,
                  onPressed: () {
                    print(
                      'for ${li[index]} pressed share button',
                    );
                  },
                ),
              ],
              isVisited: true,
              scheduledAt: '${AppStrings.visitingVisitedAchieved} 12 окт. 2020',
              workingStatus: '${AppStrings.visitingVisitedClosedUntil} 09:00',
              onDeleteButtonPressed: () {
                context
                    .read<VisitingPlaces>()
                    .deleteVisitedPlaceById(li[index].id);
              },
            ),
          );
        },
      ),
    );

    // return VisitingContent(
    //   content: li,
    //   generator: (Sight sight) {
    //     return VisitingListElement(
    //       sight: sight,
    //       cardActions: [
    //         Button.icon(
    //           icon: AppIcons.share,
    //           iconColor: Colors.white,
    //           background: Colors.transparent,
    //           onPressed: () {
    //             print('for $sight pressed share button');
    //           },
    //         ),
    //       ],
    //       isVisited: true,
    //       scheduledAt: '${AppStrings.visitingVisitedAchieved} 12 окт. 2020',
    //       workingStatus: '${AppStrings.visitingVisitedClosedUntil} 09:00',
    //       onDeleteButtonPressed: () {
    //         context.read<VisitingPlaces>().deleteVisitedPlaceById(sight.id);
    //       },
    //     );
    //   },
    // );
  }
}
