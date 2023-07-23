import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class SetsFormFields extends StatefulWidget {
  final Exercise exercise;
  final List<SetRecord> sets;
  final void Function(List<SetRecord> sets) onChanged;

  const SetsFormFields({
    super.key,
    required this.exercise,
    required this.sets,
    required this.onChanged,
  });

  @override
  State<SetsFormFields> createState() => _SetsFormFieldsState();
}

class _SetsFormFieldsState extends State<SetsFormFields> {
  @override
  Widget build(BuildContext context) {
    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        ...widget.sets.asMap().entries.map(
          (entry) {
            return SimpleCard(
              key: entry.value.key,
              elevation: 4,
              title: 'Set ${entry.key + 1}',
              actions: [
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: widget.sets.length > 1
                      ? () {
                          widget.onChanged(widget.sets..removeAt(entry.key));
                        }
                      : null,
                ),
              ],
              child: SetFormFields(
                exercise: widget.exercise,
                set: entry.value,
                onChanged: (set) {
                  widget.sets[entry.key] = set;
                  widget.onChanged(widget.sets);
                },
              ),
            );
          },
        ),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Add Set'),
          onPressed: () {
            widget.onChanged(
              widget.sets
                ..add((
                  key: UniqueKey(),
                  repetitions: widget.sets.lastOrNull?.repetitions,
                  weight: widget.sets.lastOrNull?.weight,
                )),
            );
          },
        ),
      ],
    );
  }
}

class SetFormFields extends StatefulWidget {
  final Exercise exercise;
  final SetRecord set;
  final void Function(SetRecord set) onChanged;

  const SetFormFields({
    super.key,
    required this.exercise,
    required this.set,
    required this.onChanged,
  });

  @override
  State<SetFormFields> createState() => _SetFormFieldsState();
}

class _SetFormFieldsState extends State<SetFormFields> {
  late TextEditingController _weightController;
  late TextEditingController _repetitionsController;

  @override
  void initState() {
    super.initState();

    _weightController = TextEditingController(
      text: widget.set.weight?.toString(),
    );

    _repetitionsController = TextEditingController(
      text: widget.set.repetitions?.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StandardList(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        if (widget.exercise.bodyweightFactor != 0)
          Consumer<User>(
            builder: (context, user, child) {
              return NumberFormField(
                enabled: false,
                initialValue: user.body.weight.kilograms,
                decoration: InputDecoration(
                  labelText: 'Bodyweight',
                  hintText: 'Kilograms',
                  suffix: Text('×${widget.exercise.bodyweightFactor}'),
                ),
              );
            },
          ),
        if (widget.exercise.equipmentReference != null)
          StreamBuilder(
            stream: widget.exercise.equipment,
            builder: (context, equipment) {
              return NumberFormField(
                controller: _weightController,
                onChanged: (weight) {
                  widget.onChanged((
                    key: widget.set.key,
                    weight: weight,
                    repetitions: widget.set.repetitions,
                  ));
                },
                decoration: InputDecoration(
                  labelText: equipment.data?.name ?? 'Weight',
                  hintText: 'Kilograms',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: equipment.hasData
                        ? () {
                            var newWeight = (widget.set.weight ?? 0) -
                                equipment.data!.weightIncrement.kilograms;

                            _weightController.text = newWeight.toString();

                            widget.onChanged(((
                              key: widget.set.key,
                              weight: newWeight,
                              repetitions: widget.set.repetitions,
                            )));
                          }
                        : null,
                  ),
                  // suffix: equipment.hasData && equipment.data!.loadFactor != 1
                  //     ? Text('×${equipment.data!.loadFactor}')
                  //     : null,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: equipment.hasData
                        ? () {
                            var newWeight = (widget.set.weight ?? 0) +
                                equipment.data!.weightIncrement.kilograms;

                            _weightController.text = newWeight.toString();

                            widget.onChanged((
                              key: widget.set.key,
                              weight: newWeight,
                              repetitions: widget.set.repetitions,
                            ));
                          }
                        : null,
                  ),
                ),
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null) {
                    return 'Please enter an amount.';
                  }
                  return null;
                },
              );
            },
          ),
        NumberFormField(
          controller: _repetitionsController,
          onChanged: (repetitions) {
            widget.onChanged((
              key: widget.set.key,
              weight: widget.set.weight,
              repetitions: repetitions,
            ));
          },
          decoration: InputDecoration(
            labelText: 'Repetitions',
            prefixIcon: IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                var newRepetitions = max(0, (widget.set.repetitions ?? 0) - 1);

                _repetitionsController.text = newRepetitions.toString();

                widget.onChanged((
                  key: widget.set.key,
                  weight: widget.set.weight,
                  repetitions: newRepetitions,
                ));
              },
            ),
            suffix: widget.exercise.isUnilateral ? const Text('×2') : null,
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                var newRepetitions = (widget.set.repetitions ?? 0) + 1;

                _repetitionsController.text = newRepetitions.toString();

                widget.onChanged((
                  key: widget.set.key,
                  weight: widget.set.weight,
                  repetitions: newRepetitions,
                ));
              },
            ),
          ),
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null) {
              return 'Please enter an amount.';
            }
            return null;
          },
        ),
      ],
    );
  }
}
