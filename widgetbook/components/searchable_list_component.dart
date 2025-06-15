import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/molecules/searchable_list.dart';
import 'package:widgetbook/widgetbook.dart';

class SearchableListComponent {
  static Widget defaultUseCase(BuildContext context) {
    return SearchableList<String>(
      items: Fuzzy(
        _items,
        options: FuzzyOptions(
          location: context.knobs.int.input(
            label: 'location',
            initialValue: 0,
          ),
          distance: context.knobs.int.input(
            label: 'distance',
            initialValue: 100,
          ),
          threshold: context.knobs.double.slider(
            label: 'threshold',
            initialValue: 0.6,
          ),
          maxPatternLength: context.knobs.int.input(
            label: 'maxPatternLength',
            initialValue: 32,
          ),
          isCaseSensitive: context.knobs.boolean(
            label: 'isCaseSensitive',
            initialValue: false,
          ),
          shouldSort: context.knobs.boolean(
            label: 'shouldSort',
            initialValue: true,
          ),
          shouldNormalize: context.knobs.boolean(
            label: 'shouldNormalize',
            initialValue: false,
          ),
        ),
      ),
      itemBuilder: (context, item, similarity) => ListSurface(
        title: item,
        subtitle: similarity?.decimals(2).toString(),
      ),
    );
  }
}

final List<String> _items = [
  'Apple',
  'Banana',
  'Orange',
  'Pineapple',
  'Strawberry',
  'Watermelon',
  'Grape',
  'Cherry',
  'Mango',
  'Pear',
  'Peach',
  'Papaya',
  'Kiwi',
  'Lemon',
  'Lime',
  'Coconut',
  'Avocado',
  'Grapefruit',
  'Dragonfruit',
  'Guava',
];
