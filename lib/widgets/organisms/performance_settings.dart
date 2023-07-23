import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/switch_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class PerformanceSettings extends StatelessWidget {
  const PerformanceSettings({
    super.key,
    required this.user,
    required this.onChanged,
  });

  final User user;
  final void Function(User user) onChanged;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      title: 'Performance Target',
      child: Column(
        children: [
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('NEAT'),
              suffix: Text('kcal / day'),
            ),
            initialValue: user.neat,
            onChanged: (value) {
              if (value != null) {
                user.neat = value.toDouble();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('Target Exercise'),
              suffix: Text('kcal / day'),
            ),
            initialValue: user.target.performance.calories,
            onChanged: (value) {
              if (value != null) {
                user.target.performance.calories = value.toInt();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          SwitchFormField(
            label: const Text('Auto-Adjust Consumption Target'),
            value: user.target.performance.adjustTargetConsumption,
            onChanged: (value) {
              user.target.performance.adjustTargetConsumption = value;
              onChanged(user);
            },
          ),
        ],
      ),
    );
  }
}
