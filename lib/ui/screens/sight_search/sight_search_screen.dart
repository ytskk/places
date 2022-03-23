import 'package:flutter/material.dart';
import 'package:places/controllers/sight_search_controller.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/components/app_bar.dart';
import 'package:places/ui/components/custom_text_field.dart';
import 'package:places/ui/components/empty_list.dart';
import 'package:places/ui/components/horizontal_divider.dart';
import 'package:places/ui/components/image/network_image_box.dart';
import 'package:places/ui/components/row_group.dart';
import 'package:places/ui/components/searchbar.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
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
          preferredSize: Size.fromHeight(52),
          child: SearchBar(
            onEditingComplete: () {
              print("searched for ${_searchFieldController.text}");
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

class _SearchContent extends StatelessWidget {
  final TextEditingController controller;

  const _SearchContent({
    Key? key,
    required TextEditingController this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.text.isEmpty
        ? SliverToBoxAdapter(child: _SearchRecentActivity())
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
    final List<Sight> results =
        context.read<SightSearch>().searchByName(widget.controller.text);

    return results.isEmpty
        ? EmptyList(
            iconName: AppIcons.search,
            title: AppStrings.searchScreenNotFoundTitle,
            subtitle: AppStrings.searchScreenNotFoundSubtitle,
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
        print("pressed $sight");
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return SightDetails(sight);
        }));
      },
      child: ListTile(
        title: SubstringHighlight(
          text: sight.name,
          term: context.read<SightSearch>().searchControllerText,
          textStyleHighlight: TextStyle(fontWeight: FontWeight.w700),
        ),
        // title: Text(
        //   sight.name,
        //   style: textTheme.bodyText2,
        // ),
        subtitle: Text(
          sight.type,
          style: textTheme.bodyText1,
        ),
        leading: _SightImageBox(imageUrl: sight.url),
      ),
    );
  }
}

class _SightImageBox extends StatelessWidget {
  final String imageUrl;

  const _SightImageBox({
    Key? key,
    required String this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(12),
      child: NetworkImageBox(
        imageUrl,
        width: 56,
        height: 56,
      ),
    );
  }
}

class _SearchRecentActivity extends StatelessWidget {
  const _SearchRecentActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activityList = context.watch<SightSearch>().recentActivity;

    return activityList.isEmpty
        ? _SearchRecentActivityEmpty()
        : _SearchRecentActivityRecords();
  }
}

class _SearchRecentActivityEmpty extends StatelessWidget {
  const _SearchRecentActivityEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trailingColor = Theme.of(context).textTheme.bodyText1!.color;
    final List<Sight> recommendations = mocks.toList()
      ..shuffle()
      ..take(5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        RowGroup(
          paddingLeft: 16,
          paddingBottom: 0,
          title: Text(AppStrings.searchScreenRecentActivityRecommendations
              .toUpperCase()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SearchRecentActivityList(
              content:
                  recommendations.map((Sight sight) => _ActivityListTileElement(
                        title: sight.name,
                        trailing: Icon(
                          Icons.chevron_right,
                          color: trailingColor,
                        ),
                        onTap: () {
                          context.read<SightSearch>().addActivity(sight.name);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return SightDetails(sight);
                            },
                          ));
                        },
                      )),
            ),
          ),
        ),
      ],
    );
  }
}

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
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: TextButton(
            onPressed: () {
              context.read<SightSearch>().removeAllActivities();
            },
            child: Text(AppStrings.searchScreenRecentActivityClear),
          ),
        ),
      ],
    );
  }
}

class _SearchRecentActivityList extends StatelessWidget {
  final Iterable<Widget> content;
  final Widget? trailing;

  const _SearchRecentActivityList({
    Key? key,
    required Iterable<Widget> this.content,
    Widget? this.trailing,
  }) : super(key: key);

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

class _ActivityListTileElement extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final void Function()? onTap;

  const _ActivityListTileElement({
    Key? key,
    required String this.title,
    Widget? this.trailing,
    void Function()? this.onTap,
  }) : super(key: key);

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
