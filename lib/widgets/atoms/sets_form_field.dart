import 'package:flutter/material.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class SetsFormFields extends StatefulWidget {
  final List<SetRecord> sets;
  final void Function(List<SetRecord> sets) onChanged;

  const SetsFormFields({
    super.key,
    required this.sets,
    required this.onChanged,
  });

  @override
  State<SetsFormFields> createState() => _SetsFormFieldsState();
}

class _SetsFormFieldsState extends State<SetsFormFields> {
  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      title: 'Sets',
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            widget.onChanged(
              widget.sets
                ..add((key: UniqueKey(), repetitions: null, weight: null)),
            );
          },
        ),
      ],
      child: StandardList(
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
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      widget.onChanged(
                        widget.sets
                          ..insert(entry.key, (
                            key: UniqueKey(),
                            weight: entry.value.weight,
                            repetitions: entry.value.repetitions,
                          )),
                      );
                    },
                  ),
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
                  set: entry.value,
                  onChanged: (set) {
                    widget.sets[entry.key] = set;
                    widget.onChanged(widget.sets);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SetFormFields extends StatefulWidget {
  final SetRecord set;
  final void Function(SetRecord set) onChanged;

  const SetFormFields({
    super.key,
    required this.set,
    required this.onChanged,
  });

  @override
  State<SetFormFields> createState() => _SetFormFieldsState();
}

class _SetFormFieldsState extends State<SetFormFields> {
  TextEditingController? _weightController;
  TextEditingController? _repetitionsController;

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
    return Row(
      children: [
        Expanded(
          child: NumberFormField(
            controller: _weightController,
            onChanged: (weight) {
              widget.onChanged((
                key: widget.set.key,
                weight: weight,
                repetitions: widget.set.repetitions,
              ));
            },
            decoration: const InputDecoration(
              labelText: 'Weight',
              hintText: 'Kilograms',
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null) {
                return 'Please enter an amount.';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: NumberFormField(
            controller: _repetitionsController,
            onChanged: (repetitions) {
              widget.onChanged((
                key: widget.set.key,
                weight: widget.set.weight,
                repetitions: repetitions,
              ));
            },
            decoration: const InputDecoration(
              labelText: 'Repetitions',
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null) {
                return 'Please enter an amount.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
