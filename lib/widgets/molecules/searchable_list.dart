import 'package:flutter/material.dart';
import 'package:vim/extensions/string_similarity.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class SearchableList<T> extends StatefulWidget {
  final String barHintText;
  final List<T> items;
  final String Function(T) itemToText;
  final num? minSimilarity;
  final bool? normalizeSimilarity;
  final int? maxResults;
  final Widget Function(BuildContext, T, num?) itemBuilder;
  final Widget Function(BuildContext, List<T>)? noQueryBuilder;
  final Widget Function(BuildContext)? noResultsBuilder;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double spacing;

  const SearchableList({
    super.key,
    this.barHintText = "Search",
    required this.items,
    required this.itemToText,
    this.minSimilarity = 0.1,
    this.normalizeSimilarity,
    this.maxResults,
    required this.itemBuilder,
    this.noQueryBuilder,
    this.noResultsBuilder,
    this.spacing = 16,
    this.physics,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  State<SearchableList<T>> createState() => _SearchableListState<T>();
}

class _SearchableListState<T> extends State<SearchableList<T>> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController queryController = TextEditingController();

  String query = "";

  @override
  Widget build(BuildContext context) {
    var ranked = query.isNotEmpty
        ? [...widget.items].withSimilarity(
            (item) => widget.itemToText(item).toLowerCase(),
            query,
            minSimilarity: widget.minSimilarity,
            normalizeSimilarity: widget.normalizeSimilarity,
            maxResults: widget.maxResults,
          )
        : null;

    return Column(
      children: [
        Flexible(
          flex: 0,
          child: SearchBar(
            controller: queryController,
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 16),
            ),
            leading: const Icon(Icons.search),
            hintText: widget.barHintText,
            trailing: [
              if (query.isNotEmpty)
                IconButton(
                  onPressed: () {
                    scrollController.jumpTo(0);
                    queryController.text = "";
                    setState(() => query = queryController.text);
                  },
                  icon: const Icon(Icons.clear),
                ),
            ],
            onChanged: (query) {
              scrollController.jumpTo(0);
              setState(() => this.query = query.toLowerCase());
            },
          ),
        ),
        Flexible(
          flex: 1,
          child: SingleChildScrollView(
              controller: scrollController,
              physics: widget.physics,
              child: ranked == null
                  ? buildNoQuery(context)
                  : buildResults(ranked)),
        ),
      ],
    );
  }

  Widget buildNoQuery(BuildContext context) {
    if (widget.noQueryBuilder != null) {
      return widget.noQueryBuilder!(context, widget.items);
    }

    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      spacing: widget.spacing,
      itemCount: widget.items.length,
      itemBuilder: (context, index) => widget.itemBuilder(
        context,
        widget.items[index],
        null,
      ),
    );
  }

  Widget buildResults(List<({T item, num? similarity})> ranked) {
    if (ranked.isEmpty) {
      return buildNoResults(context);
    }

    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      spacing: widget.spacing,
      itemCount: ranked.length,
      itemBuilder: (context, index) => widget.itemBuilder(
        context,
        ranked[index].item,
        ranked[index].similarity,
      ),
    );
  }

  Widget buildNoResults(BuildContext context) {
    if (widget.noResultsBuilder != null) {
      return widget.noResultsBuilder!(context);
    }

    return const StandardList(
      children: [
        ListSurface(
          title: "No Results",
        ),
      ],
    );
  }
}
