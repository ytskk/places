import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:places/data/model/place_model.dart';
import 'package:places/domain/app_constants.dart';
import 'package:places/domain/app_icons.dart';
import 'package:places/domain/app_strings.dart';
import 'package:places/ui/components/custom_app_bar.dart';
import 'package:places/ui/components/custom_text_field.dart';
import 'package:places/ui/components/image/network_image_box.dart';
import 'package:places/ui/components/info_list.dart';
import 'package:places/ui/components/loading_progress_indicator.dart';
import 'package:places/ui/components/row_group.dart';
import 'package:places/ui/components/searchbar.dart';
import 'package:places/ui/navigation/app_route_names.dart';
import 'package:places/ui/screens/sight_search/bloc/search.dart';
import 'package:places/utils/extensions/list_extension.dart';
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
          child: BlocListener<SearchBloc, SearchState>(
            listenWhen: (previous, current) => previous.query != current.query,
            listener: (context, state) {
              if (_searchFieldController.text.isEmpty) {
                _searchFieldController.text = state.query ?? '';
                _searchFieldController.selection = TextSelection.collapsed(
                  offset: _searchFieldController.text.length,
                );
              }
            },
            child: SearchBar(
              onEditingComplete: () => context.read<SearchBloc>().add(
                    SearchHistoryAdd(query: _searchFieldController.text),
                  ),
              onChange: (value) {
                context.read<SearchBloc>().add(
                      SearchChanged(query: value),
                    );
              },
              controller: _searchFieldController,
              suffix: ClearButton(
                controller: _searchFieldController,
                onChanged: (value) {
                  context.read<SearchBloc>().add(
                        SearchCleared(),
                      );
                },
              ),
              autofocus: true,
              readOnly: false,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const _SearchContent(),
          ],
        ),
      ),
    );
  }
}

/// Defines search content.
///
/// Depends on [controller] status. If text is empty, show recent activity,
/// else, search results.
class _SearchContent extends StatelessWidget {
  const _SearchContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (_, state) {
        switch (state.status) {
          case SearchStatus.empty:
            return SliverToBoxAdapter(
              child: _SearchRecentActivity(),
            );
          case SearchStatus.loading:
            return SliverFillRemaining(
              hasScrollBody: false,
              child: const Center(
                child: const LoadingProgressIndicator(),
              ),
            );
          case SearchStatus.success:
            if (state.places.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: const _SearchResultsEmpty(),
              );
            }

            return const _SearchResults();
        }
      },
    );
  }
}

class _SearchResultsEmpty extends StatelessWidget {
  const _SearchResultsEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InfoList(
        infoListData: InfoListData(
          iconName: AppIcons.search,
          iconColor: Theme.of(context).textTheme.bodyText2!.color,
          title: Text(
            AppStrings.searchScreenNotFoundTitle,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            AppStrings.searchScreenNotFoundSubtitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _SearchResults extends StatelessWidget {
  const _SearchResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        return SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final place = state.places[index];

            return _SearchResultListTile(
              searchText: state.query!,
              sight: place,
            );
          },
          childCount: state.places.length,
        ));
      },
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
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      splashColor:
          Theme.of(context).textTheme.bodyText2!.color?.withOpacity(0.5),
      onTap: () {
        context.read<SearchBloc>().add(SearchHistoryAdd(query: searchText));
        Navigator.of(context).pushNamed(
          AppRouteNames.placeDetails,
          arguments: sight.id.toString(),
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
          sight.type.name,
          style: textTheme.bodyText1,
        ),
        leading: RoundedNetworkImageBox(
          imageUrl: ListExtension(sight.urls).takeFirstImgOrTemp,
        ),
      ),
    );
  }
}

/// Recent activity component, empty if it's no history.
class _SearchRecentActivity extends StatelessWidget {
  const _SearchRecentActivity({Key? key}) : super(key: key);

  // BUG: history does not update on delete or clear.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        if (state.history.isEmpty) {
          return _SearchRecentActivityEmpty();
        }

        return _SearchRecentActivityRecords();
      },
    );
  }
}

class _SearchRecentActivityEmpty extends StatelessWidget {
  const _SearchRecentActivityEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}

/// Shows existed recent activities record. Takes 5 recent records.
class _SearchRecentActivityRecords extends StatelessWidget {
  const _SearchRecentActivityRecords({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RowGroup(
              paddingLeft: 16,
              paddingBottom: 0,
              title: Text(
                AppStrings.searchScreenRecentActivity.toUpperCase(),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _SearchRecentActivityList(
                  children: state.history
                      .map(
                        (history) => _ActivityListTileItem(
                          onTap: () {
                            context.read<SearchBloc>().add(
                                  SearchChanged(query: history.value),
                                );
                          },
                          title: history.value,
                          trailing: IconButton(
                            onPressed: () {
                              context.read<SearchBloc>().add(
                                    SearchHistoryRemove(
                                      historyRecord: history,
                                    ),
                                  );
                            },
                            icon: const Icon(Icons.clear),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            const Padding(
              padding: const EdgeInsets.only(left: 8),
              child: _SearchRecentActivityClearHistoryButton(),
            ),
          ],
        );
      },
    );
  }
}

class _SearchRecentActivityList extends StatelessWidget {
  const _SearchRecentActivityList({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: false,
      itemCount: children.length,
      itemBuilder: (BuildContext context, int index) {
        return children.elementAt(index);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          indent: 0,
        );
      },
    );
  }
}

class _SearchRecentActivityClearHistoryButton extends StatelessWidget {
  const _SearchRecentActivityClearHistoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<SearchBloc>().add(SearchHistoryClear());
      },
      child: Text(AppStrings.searchScreenRecentActivityClear),
    );
  }
}

/// Creates element for [_SearchRecentActivityList]
class _ActivityListTileItem extends StatelessWidget {
  /// Customised dense [ListTile] with secondary title text style.
  ///
  /// [onTap] sets main text controller to [title] value.
  /// [trailing] removes this from history.
  const _ActivityListTileItem({
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
