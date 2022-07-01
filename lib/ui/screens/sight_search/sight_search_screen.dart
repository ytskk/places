import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/data/redux/states/app_state.dart';
import 'package:places/data/redux/states/search_state.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:places/ui/components/image/network_image_box.dart';
import 'package:places/ui/components/loading_progress_indicator.dart';
import 'package:places/ui/navigation/app_route_names.dart';
import 'package:places/utils/extensions/list_extension.dart';
import 'package:redux/redux.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  State<SightSearchScreen> createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  late final TextEditingController _searchFieldController;

  @override
  void initState() {
    super.initState();

    _searchFieldController = TextEditingController();
    _searchFieldController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();

    _searchFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backButtonColor = Theme.of(context).textTheme.bodyText2!.color;

    return Center(
      child: Text('213'),
    );
    // return Scaffold(
    //   appBar: CustomAppBar(
    //     leading: BackButton(
    //       color: backButtonColor,
    //     ),
    //     title: Text(AppStrings.sightTitle),
    //     bottom: PreferredSize(
    //       preferredSize: Size.fromHeight(bottomAppBarHeight),
    //       child: SearchBar(
    //         onChange: (value) {
    //           print('onChange: $value');
    //           StoreProvider.of<AppState>(context).dispatch(LoadSearchAction(
    //             PlacesFilterRequestDto(
    //               nameFilter: value,
    //               radius: 10000000.0,
    //               lat: 55.754093,
    //               lng: 37.620407,
    //               typeFilter: context.read<Filter>().selectedCategories,
    //             ),
    //           ));
    //         },
    //         controller: _searchFieldController,
    //         suffix: ClearButton(
    //           controller: _searchFieldController,
    //         ),
    //         autofocus: true,
    //         readOnly: false,
    //       ),
    //     ),
    //   ),
    //   body: SafeArea(
    //     child: CustomScrollView(
    //       slivers: [
    //         _SearchContent(controller: _searchFieldController),
    //       ],
    //     ),
    //   ),
    // );
  }
}

/// Defines search content.
///
/// Depends on [controller] status. If text is empty, show recent activity,
/// else, search results
class _SearchContent extends StatelessWidget {
  final TextEditingController controller;

  const _SearchContent({
    Key? key,
    required TextEditingController this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.text.trim().isEmpty
        ? SliverToBoxAdapter(
            // child: _SearchRecentActivity(),
            child: SizedBox(),
          )
        : StoreConnector(
            converter: (Store<AppState> store) {
              return store.state.searchState;
            },
            builder: (BuildContext context, vm) {
              if (vm is LoadingSearchState) {
                return SliverFillRemaining(
                  child: LoadingProgressIndicator(),
                );
              }

              if (vm is ResultSearchState) {
                final results = vm.places;
                print(results);

                return SliverFillRemaining(
                  child: _SearchResultsList(
                    content: results,
                    searchText: controller.text.trim(),
                  ),
                );
              }

              return SliverFillRemaining(
                child: Text("eoor"),
              );
            },
          );
  }
}

class _SearchResultsList extends StatelessWidget {
  const _SearchResultsList({
    Key? key,
    required this.content,
    required this.searchText,
  }) : super(key: key);

  final List<PlaceDto> content;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultListTile(
            sight: content[index], searchText: searchText);
      },
      separatorBuilder: (BuildContext context, int index) {
        return HorizontalDividerInset();
      },
      itemCount: content.length,
    );
  }
}

class _SearchResultListTile extends StatelessWidget {
  const _SearchResultListTile({
    Key? key,
    required this.sight,
    required this.searchText,
  }) : super(key: key);

  final PlaceDto sight;
  final String searchText;

  @override
  Widget build(BuildContext context) {
    print('_SearchResultListTile: ${sight.urls}, ${sight.type}');
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      splashColor: Colors.black12,
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouteNames.placeDetails,
          arguments: sight.id,
        );
      },
      child: ListTile(
        title: SubstringHighlight(
          text: sight.name,
          term: searchText,
          textStyle: textTheme.bodyText2!,
          textStyleHighlight:
              textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          sight.type,
          style: textTheme.bodyText1,
        ),
        // leading: _SightImageBox(imageUrl: sight.url),
        leading: RoundedNetworkImageBox(
          imageUrl: ListExtension(sight.urls).takeFirstImgOrTemp,
        ),
      ),
    );
  }
}
//
// /// Recent activity component, empty if it's no history.
// class _SearchRecentActivity extends StatelessWidget {
//   const _SearchRecentActivity({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final activityList = context.watch<SightSearch>().recentActivity;
//
//     return activityList.isEmpty
//         ? SizedBox.shrink()
//         : _SearchRecentActivityRecords();
//   }
// }
//
// /// Shows existed recent activities record. Takes 5 recent records.
// class _SearchRecentActivityRecords extends StatelessWidget {
//   const _SearchRecentActivityRecords({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final trailingColor = Theme.of(context).textTheme.bodyText1!.color;
//     final activityList =
//         context.watch<SightSearch>().recentActivity.take(5).toList();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         RowGroup(
//           paddingLeft: 16,
//           paddingBottom: 0,
//           title: Text(AppStrings.searchScreenRecentActivity.toUpperCase()),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: _SearchRecentActivityList(
//               content: activityList.map((ActivityRecord e) =>
//                   _ActivityListTileElement(
//                     title: e.value,
//                     onTap: () {
//                       context.read<SightSearch>().setControllerText(e.value);
//                     },
//                     trailing: IconButton(
//                       onPressed: () {
//                         context.read<SightSearch>().removeActivityById(e.id);
//                       },
//                       icon: Icon(
//                         Icons.close,
//                         color: trailingColor,
//                       ),
//                     ),
//                   )),
//             ),
//           ),
//         ),
//         const Padding(
//           padding: const EdgeInsets.only(left: 8),
//           child: _SearchRecentActivityClearHistoryButton(),
//         ),
//       ],
//     );
//   }
// }
//
// class _SearchRecentActivityClearHistoryButton extends StatelessWidget {
//   const _SearchRecentActivityClearHistoryButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         context.read<SightSearch>().removeAllActivities();
//       },
//       child: Text(AppStrings.searchScreenRecentActivityClear),
//     );
//   }
// }
//
// /// List with divided titles of recent activity.
// ///
// /// Accepts Iterable [content] to use in [tiles].
// class _SearchRecentActivityList extends StatelessWidget {
//   const _SearchRecentActivityList({
//     Key? key,
//     required this.content,
//     this.trailing,
//   }) : super(key: key);
//
//   final Iterable<Widget> content;
//   final Widget? trailing;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: ListTile.divideTiles(
//         context: context,
//         tiles: content,
//       ).toList(),
//     );
//   }
// }
//
// /// Creates element for [_SearchRecentActivityList]
// class _ActivityListTileElement extends StatelessWidget {
//   /// Customised dense [ListTile] with secondary title text style.
//   ///
//   /// [onTap] sets main text controller to [title] value.
//   /// [trailing] removes this from history.
//   const _ActivityListTileElement({
//     Key? key,
//     required this.title,
//     this.trailing,
//     this.onTap,
//   }) : super(key: key);
//
//   final String title;
//   final Widget? trailing;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final titleStyle = Theme.of(context).textTheme.bodyText1;
//
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       onTap: onTap,
//       dense: true,
//       title: Text(
//         title,
//         style: titleStyle,
//       ),
//       trailing: trailing,
//     );
//   }
// }
