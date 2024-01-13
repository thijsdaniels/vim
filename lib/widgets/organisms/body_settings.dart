import 'package:flutter/material.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/distance.dart';
import 'package:vim/models/mass.dart';
import 'package:vim/models/user/body.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/incremental_number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class BodySettings extends StatelessWidget {
  const BodySettings({
    super.key,
    required this.user,
    required this.onChanged,
  });

  final User user;
  final void Function(User user) onChanged;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      title: 'Body',
      child: StandardList(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          DropdownButtonFormField(
            decoration: const InputDecoration(
              label: Text('Gender'),
            ),
            value: user.body.gender,
            items: Gender.values
                .map(
                  (gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender.name.toTitleCase()),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                user.body.gender = value;
                onChanged(user);
              }
            },
          ),
          IncrementalNumberFormField(
            decoration: const InputDecoration(
              label: Text('Age'),
            ),
            initialValue: user.body.age,
            onChanged: (value) {
              if (value != null) {
                user.body.age = value.toInt();
                onChanged(user);
              }
            },
          ),
          IncrementalNumberFormField(
            decoration: const InputDecoration(
              label: Text('Length'),
              suffix: Text('cm'),
            ),
            initialValue: user.body.length?.centimeters,
            onChanged: (value) {
              if (value != null) {
                user.body.length = Distance.centimeters(value.toInt());
                onChanged(user);
              }
            },
          ),
          IncrementalNumberFormField(
            decoration: const InputDecoration(
              label: Text('Weight'),
              suffix: Text('kg'),
            ),
            initialValue: user.body.weight.kilograms,
            onChanged: (value) {
              if (value != null) {
                user.body.weight = Mass.kilograms(value.toDouble());
                onChanged(user);
              }
            },
          ),
          IncrementalNumberFormField(
            decoration: const InputDecoration(
              label: Text('Lean Mass'),
              suffix: Text('%'),
            ),
            initialValue: user.body.composition.lean != null
                ? (user.body.composition.lean! * 100).decimals(1)
                : null,
            onChanged: (value) {
              if (value != null) {
                user.body.composition.lean = (value / 100).toDouble();
                onChanged(user);
              }
            },
          ),
          IncrementalNumberFormField(
            decoration: const InputDecoration(
              label: Text('Fat Mass'),
              suffix: Text('%'),
            ),
            initialValue: user.body.composition.fat != null
                ? (user.body.composition.fat! * 100).decimals(1)
                : null,
            onChanged: (value) {
              if (value != null) {
                user.body.composition.fat = (value / 100).toDouble();
                onChanged(user);
              }
            },
          ),
          IncrementalNumberFormField(
            decoration: const InputDecoration(
              label: Text('Bone Mass'),
              suffix: Text('%'),
            ),
            initialValue: user.body.composition.bone != null
                ? (user.body.composition.bone! * 100).decimals(1)
                : null,
            onChanged: (value) {
              if (value != null) {
                user.body.composition.bone = (value / 100).toDouble();
                onChanged(user);
              }
            },
          ),
        ],
      ),
    );
  }
}
