import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/food_icon.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:widgetbook/widgetbook.dart';

class ListSurfaceComponent {
  static Widget defaultUseCase(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: ListSurface(
        icon: FoodIcon(
          context.knobs.list(
            label: 'Icon',
            options: foodIcons.values.map((data) => data.slug).toList(),
            initialOption: foodIcons['basil']!.slug,
          ),
        ),
        title: context.knobs.string(
          label: 'title',
          initialValue: 'Title',
        ),
        subtitle: context.knobs.string(
          label: 'subtitle',
          initialValue: 'Subtitle',
        ),
        trailing: const Icon(Icons.more_vert),
      ),
    );
  }
}
