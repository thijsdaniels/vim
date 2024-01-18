import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class ListSurfaceStory extends Story {
  ListSurfaceStory()
      : super(
          name: 'Widgets/ListSurface',
          builder: (context) => ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: ListSurface(
              icon: const Icons8Icon(
                'basil',
                style: Icons8Style.stickers,
              ),
              title: context.knobs.text(
                label: 'title',
                initial: 'Title',
              ),
              subtitle: context.knobs.text(
                label: 'subtitle',
                initial: 'Subtitle',
              ),
              trailing: const Icon(
                Icons.more_vert,
              ),
            ),
          ),
        );
}
