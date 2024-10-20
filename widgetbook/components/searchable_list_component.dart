import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/molecules/searchable_list.dart';
import 'package:widgetbook/widgetbook.dart';

class SearchableListComponent {
  static Widget defaultUseCase(BuildContext context) {
    return SearchableList<String>(
      items: _items,
      itemToText: (item) => item,
      itemBuilder: (context, item, similarity) => ListSurface(
        title: item,
        subtitle: similarity?.decimals(2).toString(),
      ),
      minSimilarity: context.knobs.double.slider(
        label: 'minSimilarity',
        initialValue: 0.1,
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
