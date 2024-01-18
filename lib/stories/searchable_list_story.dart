import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/molecules/searchable_list.dart';
import 'package:vim/extensions/num.dart';

final List<String> items = [
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

var apple = Ingredient(
  user: null,
  name: 'Apple',
  nutrition: const Nutrition(),
  icon: 'apple',
);

class SearchableListStory extends Story {
  SearchableListStory()
      : super(
          name: 'Widgets/SearchableList',
          builder: (context) => SearchableList<String>(
            items: items,
            itemToText: (item) => item,
            itemBuilder: (context, item, similarity) => ListSurface(
              title: item,
              subtitle: similarity?.decimals(2).toString(),
            ),
            minSimilarity: context.knobs.slider(
              label: 'minSimilarity',
              initial: 0.1,
            ),
            normalizeSimilarity: context.knobs.boolean(
              label: 'normalizeSimilarity',
              initial: false,
            ),
            maxResults: (() {
              try {
                return int.parse(
                  context.knobs.text(
                    label: 'maxResults',
                    initial: '',
                  ),
                );
              } catch (error) {
                return null;
              }
            })(),
          ),
        );
}
