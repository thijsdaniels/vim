import 'package:flutter/material.dart';
import 'package:vim/vim.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components/incremental_number_form_field_component.dart';
import 'components/ingredient_list_surface_component.dart';
import 'components/line_chart_component.dart';
import 'components/list_surface_component.dart';
import 'components/searchable_list_component.dart';

void main() {
  runApp(const WidgetbookApp());
}

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      appBuilder: (context, home) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Widgetbook',
        theme: lightTheme(Colors.deepPurple),
        darkTheme: darkTheme(Colors.deepPurple),
        themeMode: ThemeMode.dark,
        home: home,
      ),
      addons: [
        DeviceFrameAddon(devices: Devices.all),
        InspectorAddon(),
        // GridAddon(32),
        AlignmentAddon(),
        ZoomAddon(),
      ],
      directories: [
        WidgetbookFolder(
          name: 'Widgets',
          children: [
            WidgetbookComponent(
              name: 'ListSurface',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: ListSurfaceComponent.defaultUseCase,
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'IngredientListSurface',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: IngredientListSurfaceComponent.defaultUseCase,
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'LineChart',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: LineChartComponent.defaultUseCase,
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'SearchableList',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: SearchableListComponent.defaultUseCase,
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'IncrementalNumberFormField',
              useCases: [
                WidgetbookUseCase(
                  name: 'Uncontrolled',
                  builder:
                      IncrementalNumberFormFieldComponent.uncontrolledUseCase,
                ),
                WidgetbookUseCase(
                  name: 'Controlled',
                  builder:
                      IncrementalNumberFormFieldComponent.controlledUseCase,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
