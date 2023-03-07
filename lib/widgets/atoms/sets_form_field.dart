import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';

class SetsFormFields extends StatefulWidget {
  final List<Map<String, dynamic>> sets;
  final double elevation;

  const SetsFormFields({
    super.key,
    required this.sets,
    this.elevation = 1,
  });

  @override
  State<SetsFormFields> createState() => _SetsFormFieldsState();
}

class _SetsFormFieldsState extends State<SetsFormFields> {
  @override
  Widget build(BuildContext context) {
    var sets = widget.sets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...sets.asMap().entries.map(
          (entry) {
            return Card(
              elevation: widget.elevation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: NumberFormField(
                        initialValue: entry.value['repetitions'],
                        onChanged: (repetitions) => setState(() {
                          entry.value['repetitions'] = repetitions;
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
                    Expanded(
                      child: NumberFormField(
                        initialValue: entry.value['weight'],
                        onChanged: (weight) => setState(() {
                          entry.value['weight'] = weight;
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
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: sets.length > 1
                          ? () {
                              setState(() {
                                sets.removeAt(entry.key);
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
                sets.add({
                  'repetitions':
                      sets.isNotEmpty ? sets.last['repetitions'] : null,
                  'weight': sets.isNotEmpty ? sets.last['weight'] : null,
                });
              });
            },
          ),
        ),
      ],
    );
  }
}
