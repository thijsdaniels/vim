import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:vim/widgets/atoms/incremental_number_form_field.dart';

class IncrementalNumberFormFieldStory extends Story {
  IncrementalNumberFormFieldStory()
      : super(
          name: 'Widgets/IncrementalNumberFormField',
          builder: (context) => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: IncrementalNumberFormField(
                decoration: InputDecoration(
                  labelText: context.knobs.text(
                    label: 'labelText',
                    initial: 'Uncontrolled',
                  ),
                ),
                initialValue: num.parse(
                  context.knobs.text(
                    label: 'initialValue',
                    initial: '5',
                  ),
                ),
                stepSize: num.parse(
                  context.knobs.text(
                    label: 'stepSize',
                    initial: '2.5',
                  ),
                ),
              ),
            ),
          ),
        );
}
