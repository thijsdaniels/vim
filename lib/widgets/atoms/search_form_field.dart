import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class SearchFormField<T> extends StatelessWidget {
  final SearchController _controller = SearchController();
  late final String Function(T option) _titleBuilder;
  late final bool Function(T option, String query) _filter;

  final T? selection;
  final void Function(T? icon)? onSelected;
  final InputDecoration? decoration;
  final List<T> options;
  final FutureOr<String?> Function(T option)? subtitleBuilder;
  final FutureOr<Widget?> Function(T option)? iconBuilder;

  SearchFormField({
    super.key,
    this.selection,
    this.onSelected,
    this.decoration,
    required this.options,
    bool Function(T option, String query)? filter,
    String Function(T option)? titleBuilder,
    this.subtitleBuilder,
    this.iconBuilder,
  }) {
    _filter = filter ?? _defaultFilter;
    _titleBuilder = titleBuilder ?? _defaultTitleBuilder;

    if (selection != null) {
      _controller.text = _titleBuilder(selection!);
    }
  }

  String _defaultTitleBuilder(T option) => option.toString();

  bool _defaultFilter(T option, String query) =>
      _titleBuilder(option).toLowerCase().contains(query.toLowerCase());

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: _controller,
      builder: (context, controller) => TextFormField(
        controller: controller,
        decoration: decoration,
        onTap: controller.openView,
      ),
      viewElevation: 1,
      isFullScreen: true,
      suggestionsBuilder: (context, controller) {
        return [
          const SizedBox(height: 16),
          ...options
              .where((option) => _filter(option, controller.value.text))
              .map(
                (option) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: FutureBuilder(
                    future: iconBuilder != null
                        ? Future.value(iconBuilder!(option))
                        : null,
                    builder: (context, icon) => FutureBuilder(
                      future: subtitleBuilder != null
                          ? Future.value(subtitleBuilder!(option))
                          : null,
                      builder: (context, subtitle) => ListSurface(
                        elevation: 4,
                        icon: icon.data,
                        title: _titleBuilder(option),
                        subtitle: subtitle.data,
                        onTap: () {
                          if (onSelected != null) {
                            onSelected!(option);
                          }
                          controller.text = _titleBuilder(option);
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ),
              ),
          const SizedBox(height: 16),
        ];
      },
    );
  }
}
