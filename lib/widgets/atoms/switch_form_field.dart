import 'package:flutter/material.dart';

class SwitchFormField extends StatelessWidget {
  final Widget label;
  final bool value;
  final Function(bool value) onChanged;

  const SwitchFormField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        label,
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
