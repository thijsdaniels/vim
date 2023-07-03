import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class SetsFormFields extends StatefulWidget {
  final List<({num? repetitions, num? weight})> sets;
  final void Function(List<({num? repetitions, num? weight})> sets) onChanged;

  const SetsFormFields({
    super.key,
    required this.sets,
    required this.onChanged,
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
    return SimpleCard(
      title: 'Sets',
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            setState(() {
              _sets.add((repetitions: null, weight: null));
              widget.onChanged(_sets);
            });
          },
        ),
      ],
      child: StandardList(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          ..._sets.asMap().entries.map(
            (entry) {
              var (:repetitions, :weight) = entry.value;

              return SimpleCard(
                elevation: 4,
                key: Key(entry.toString()),
                title: 'Set ${entry.key + 1}',
                actions: [
                  IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        setState(() {
                          _sets.insert(entry.key + 1, (
                            repetitions: entry.value.repetitions,
                            weight: entry.value.weight,
                          ));
                          widget.onChanged(_sets);
                        });
                      }),
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
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
