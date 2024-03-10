import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:vim/stories/incremental_number_form_field_story.dart';
import 'package:vim/stories/ingredient_list_surface_story.dart';
import 'package:vim/stories/line_chart_story.dart';
import 'package:vim/stories/list_surface_story.dart';
import 'package:vim/stories/searchable_list_story.dart';

void main() async {
  runApp(Storybook(
    initialStory: 'Widgets/ListSurface',
    stories: [
      IncrementalNumberFormFieldStory(),
      SearchableListStory(),
      LineChartStory(),
      IngredientListSurfaceStory(),
      ListSurfaceStory(),
    ],
  ));
}
