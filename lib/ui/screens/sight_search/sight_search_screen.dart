import 'package:flutter/material.dart';
import 'package:places/controllers/sight_search_controller.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_routes.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/models/sight.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/custom_text_field.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:places/ui/components/image/network_image_box.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/row_group.dart';
import 'package:places/ui/components/searchbar.dart';
import 'package:provider/provider.dart';
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

    context.read<SightSearch>().bindSearchController(_searchFieldController);
  }

  @override
  void dispose() {
    super.dispose();

    _searchFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backButtonColor = Theme.of(context).textTheme.bodyText2!.color;

    return Scaffold(
      appBar: CustomAppBar(
        leading: BackButton(
          color: backButtonColor,
        ),
        title: Text(AppStrings.sightTitle),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(bottomAppBarHeight),
          child: SearchBar(
            onEditingComplete: () {
              print('searched for ${_searchFieldController.text}');
              context
                  .read<SightSearch>()
                  .addActivity(_searchFieldController.text);
            },
            controller: _searchFieldController,
            suffix: ClearButton(
              controller: _searchFieldController,
            ),
            autofocus: true,
            readOnly: false,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _SearchContent(controller: _searchFieldController),
          ],
        ),
      ),
    );
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
            child: _SearchRecentActivity(),
          )
        : SliverFillRemaining(
            child: _SearchResults(controller: controller),
          );
  }
}

class _SearchResults extends StatefulWidget {
  final TextEditingController controller;

  const _SearchResults({
    Key? key,
    required TextEditingController this.controller,
  }) : super(key: key);

  @override
  State<_SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<_SearchResults> {
  @override
  Widget build(BuildContext context) {
    // final List<Sight> filteredSights = context.watch<Filter>().nearbyPlaces;
    final List<Sight> results = context
        .read<SightSearch>()
        .searchByName(widget.controller.text.trim(), domain: []);
    final theme = Theme.of(context);

    return results.isEmpty
        ? Center(
            child: InfoList(
              iconName: AppIcons.search,
              iconColor: theme.textTheme.bodyText2!.color,
              title: Text(
                AppStrings.searchScreenNotFoundTitle,
                textAlign: TextAlign.center,
              ),
              subtitle: Text(
                AppStrings.searchScreenNotFoundSubtitle,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : _SearchResultsList(content: results);
  }
}

class _SearchResultsList extends StatelessWidget {
  final List<Sight> content;

  const _SearchResultsList({
    Key? key,
    required List<Sight> this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultListTile(sight: content[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return HorizontalDividerInset();
      },
      itemCount: content.length,
    );
  }
}

class _SearchResultListTile extends StatelessWidget {
  final Sight sight;

  const _SearchResultListTile({
    Key? key,
    required Sight this.sight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      splashColor: Colors.black12,
      onTap: () {
        context
            .read<SightSearch>()
            .addActivity(context.read<SightSearch>().searchControllerText);
        Navigator.of(context).pushNamed(
          AppRoutes.sightDetails,
          arguments: sight.id,
        );
      },
      child: ListTile(
        title: SubstringHighlight(
          text: sight.name,
          term: context.read<SightSearch>().searchControllerText.trim(),
          textStyle: textTheme.bodyText2!,
          textStyleHighlight:
              textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          sight.type,
          style: textTheme.bodyText1,
        ),
        // leading: _SightImageBox(imageUrl: sight.url),
        leading: RoundedNetworkImageBox(imageUrl: sight.url),
      ),
    );
  }
}

/// Recent activity component, empty if it's no history.
class _SearchRecentActivity extends StatelessWidget {
  const _SearchRecentActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activityList = context.watch<SightSearch>().recentActivity;

    return activityList.isEmpty
        ? SizedBox.shrink()
        : _SearchRecentActivityRecords();
  }
}

/// Shows existed recent activities record. Takes 5 recent records.
class _SearchRecentActivityRecords extends StatelessWidget {
  const _SearchRecentActivityRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trailingColor = Theme.of(context).textTheme.bodyText1!.color;
    final activityList =
        context.watch<SightSearch>().recentActivity.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RowGroup(
          paddingLeft: 16,
          paddingBottom: 0,
          title: Text(AppStrings.searchScreenRecentActivity.toUpperCase()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SearchRecentActivityList(
              content: activityList.map((ActivityRecord e) =>
                  _ActivityListTileElement(
                    title: e.value,
                    onTap: () {
                      context.read<SightSearch>().setControllerText(e.value);
                    },
                    trailing: IconButton(
                      onPressed: () {
                        context.read<SightSearch>().removeActivityById(e.id);
                      },
                      icon: Icon(
                        Icons.close,
                        color: trailingColor,
                      ),
                    ),
                  )),
            ),
          ),
        ),
        const Padding(
          padding: const EdgeInsets.only(left: 8),
          child: _SearchRecentActivityClearHistoryButton(),
        ),
      ],
    );
  }
}

class _SearchRecentActivityClearHistoryButton extends StatelessWidget {
  const _SearchRecentActivityClearHistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<SightSearch>().removeAllActivities();
      },
      child: Text(AppStrings.searchScreenRecentActivityClear),
    );
  }
}

/// List with divided titles of recent activity.
///
/// Accepts Iterable [content] to use in [tiles].
class _SearchRecentActivityList extends StatelessWidget {
  const _SearchRecentActivityList({
    Key? key,
    required this.content,
    this.trailing,
  }) : super(key: key);

  final Iterable<Widget> content;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: ListTile.divideTiles(
        context: context,
        tiles: content,
      ).toList(),
    );
  }
}

/// Creates element for [_SearchRecentActivityList]
class _ActivityListTileElement extends StatelessWidget {
  /// Customised dense [ListTile] with secondary title text style.
  ///
  /// [onTap] sets main text controller to [title] value.
  /// [trailing] removes this from history.
  const _ActivityListTileElement({
    Key? key,
    required this.title,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.bodyText1;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      dense: true,
      title: Text(
        title,
        style: titleStyle,
      ),
      trailing: trailing,
    );
  }
}
