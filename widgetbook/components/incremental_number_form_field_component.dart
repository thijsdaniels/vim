import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/incremental_number_form_field.dart';
import 'package:widgetbook/widgetbook.dart';

class IncrementalNumberFormFieldComponent {
  static Widget uncontrolledUseCase(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: IncrementalNumberFormField(
        decoration: InputDecoration(
          labelText: context.knobs.string(
            label: 'labelText',
            initialValue: 'Uncontrolled',
          ),
        ),
        initialValue: context.knobs.doubleOrNull.input(
          label: 'initialValue',
          initialValue: 5,
        ),
        stepSize: context.knobs.double.input(
          label: 'stepSize',
          initialValue: 2.5,
        ),
      ),
    );
  }

  static Widget controlledUseCase(BuildContext context) {
    var controller = TextEditingController(
      text: context.knobs.doubleOrNull
          .input(
            label: 'initialValue',
            initialValue: 5,
          )
          .toString(),
    );

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: IncrementalNumberFormField(
        decoration: InputDecoration(
          labelText: context.knobs.string(
            label: 'labelText',
            initialValue: 'Controlled',
          ),
        ),
        controller: controller,
        stepSize: context.knobs.double.input(
          label: 'stepSize',
          initialValue: 2.5,
        ),
      ),
    );
  }
}
