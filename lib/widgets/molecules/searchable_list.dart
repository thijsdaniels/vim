import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fuzzy/data/result.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class SearchableList<T> extends StatefulWidget {
  final String barHintText;
  final Fuzzy<T> items;
  final Widget Function(BuildContext, T, double?) itemBuilder;
  final Widget Function(BuildContext, List<T>)? noQueryBuilder;
  final Widget Function(BuildContext)? noResultsBuilder;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double spacing;

  const SearchableList({
    super.key,
    this.barHintText = "Search",
    required this.items,
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
            child: _query.isEmpty
                ? buildNoQuery(context)
                : buildResults(widget.items.search(_query)),
          ),
        ),
      ],
    );
  }

  Widget buildNoQuery(BuildContext context) {
    if (widget.noQueryBuilder != null) {
      return widget.noQueryBuilder!(context, widget.items.list);
    }

    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      spacing: widget.spacing,
      itemCount: widget.items.list.length,
      itemBuilder: (context, index) => widget.itemBuilder(
        context,
        widget.items.list[index],
        null,
      ),
    );
  }

  Widget buildResults(List<Result<T>> results) {
    if (results.isEmpty) {
      return buildNoResults(context);
    }

    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: widget.padding,
      spacing: widget.spacing,
      itemCount: results.length,
      itemBuilder: (context, index) => widget.itemBuilder(
        context,
        results[index].item,
        results[index].score,
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
