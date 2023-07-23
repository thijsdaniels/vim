import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/standard_list.dart';

class SliderFormField extends StatelessWidget {
  final double value;
  final void Function(double value)? onChanged;
  final double? secondaryTrackValue;
  final Widget? label;
  final String? valueLabel;
  final double min;
  final double max;
  final int? divisions;

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
  });

  @override
  build(BuildContext context) {
    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        if (label != null || valueLabel != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label ?? const SizedBox(),
              valueLabel != null ? Text(valueLabel!) : const SizedBox(),
            ],
          ),
        Slider(
          value: value,
          onChanged: onChanged,
          secondaryTrackValue: secondaryTrackValue,
          label: valueLabel,
          min: min,
          max: max,
          divisions: divisions,
        ),
      ],
    );
  }
}
