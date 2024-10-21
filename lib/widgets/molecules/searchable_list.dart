import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:fuzzywuzzy/model/extracted_result.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class SearchableList<T> extends StatefulWidget {
  final String barHintText;
  final List<T> items;
  final String Function(T) itemToText;
  final num minSimilarity;
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
    this.minSimilarity = 0.5,
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

  String _query = "";
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var ranked = _query.isNotEmpty
        ? extractAllSorted(
            query: _query,
            choices: widget.items,
            getter: (item) => widget.itemToText(item),
            cutoff: (widget.minSimilarity * 100).toInt(),
          )
        : null;

    return Column(
      children: [
        Flexible(
          flex: 0,
          child: SearchBar(
            controller: queryController,
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(),
            ),
            padding: WidgetStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(horizontal: 16),
            ),
            leading: const Icon(Icons.search),
            hintText: widget.barHintText,
            trailing: [
              if (_query.isNotEmpty)
                IconButton(
                  onPressed: () {
                    scrollController.jumpTo(0);
                    queryController.text = "";
                    setState(() => _query = queryController.text);
                  },
                  icon: const Icon(Icons.clear),
                ),
            ],
            onChanged: (query) {
              scrollController.jumpTo(0);

              if (_debounce?.isActive ?? false) {
                _debounce?.cancel();
              }

              _debounce = Timer(const Duration(milliseconds: 300), () {
                setState(() => this._query = query);
              });
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

  Widget buildResults(List<ExtractedResult<T>> ranked) {
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
        ranked[index].choice,
        ranked[index].score,
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
