import 'package:flutter/material.dart';

class SliderFormField extends StatelessWidget {
  final double value;
  final void Function(double value)? onChanged;
  final double? secondaryTrackValue;
  final Widget? label;
  final String? valueLabel;
  final double min;
  final double max;
  final int? divisions;
  final bool? enabled;

  const SliderFormField({
    super.key,
    required this.value,
    this.onChanged,
    this.secondaryTrackValue,
    this.label,
    this.valueLabel,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.enabled,
  }) : assert(
          onChanged != null || enabled == false,
          'An onChanged handler must be provided if the field is not disabled.',
        );

  @override
  build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || valueLabel != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label ?? const SizedBox(),
              valueLabel != null ? Text(valueLabel!) : const SizedBox(),
            ],
          ),
        if (enabled != false)
          Slider(
            value: value,
            onChanged: onChanged,
            secondaryTrackValue: secondaryTrackValue,
            label: valueLabel,
            min: min,
            max: max,
            divisions: divisions,
          ),
        if (enabled == false)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: (value - min) / (max - min),
                minHeight: 6,
              ),
            ),
          ),
      ],
    );
  }
}
