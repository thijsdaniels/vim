import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';

class SetsFormFields extends StatefulWidget {
  final List<({num? repetitions, num? weight})> sets;
  final void Function(List<({num? repetitions, num? weight})> sets) onChanged;
  final double elevation;

  const SetsFormFields({
    super.key,
    required this.sets,
    required this.onChanged,
    this.elevation = 1,
  });

  @override
  State<SetsFormFields> createState() => _SetsFormFieldsState();
}

class _SetsFormFieldsState extends State<SetsFormFields> {
  late List<({num? repetitions, num? weight})> _sets;

  @override
  void initState() {
    super.initState();

    _sets = widget.sets;
  }

  @override
  Widget build(BuildContext context) {
    return StandardList(
      padding: EdgeInsets.zero,
      children: [
        ..._sets.asMap().entries.map(
          (entry) {
            var (:repetitions, :weight) = entry.value;

            return Card(
              elevation: widget.elevation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: NumberFormField(
                        initialValue: weight,
                        onChanged: (value) => setState(() {
                          _sets[entry.key] = (
                            weight: value,
                            repetitions: entry.value.repetitions,
                          );
                          widget.onChanged(_sets);
                        }),
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
                        initialValue: repetitions,
                        onChanged: (value) => setState(() {
                          _sets[entry.key] = (
                            weight: entry.value.weight,
                            repetitions: value,
                          );
                          widget.onChanged(_sets);
                        }),
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
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _sets.length > 1
                          ? () {
                              setState(() {
                                _sets.removeAt(entry.key);
                                widget.onChanged(_sets);
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: const Text('Add Set'),
            onPressed: () {
              setState(() {
                _sets.add((
                  repetitions: _sets.isNotEmpty ? _sets.last.repetitions : null,
                  weight: _sets.isNotEmpty ? _sets.last.weight : null,
                ));
                widget.onChanged(_sets);
              });
            },
          ),
        ),
      ],
    );
  }
}
