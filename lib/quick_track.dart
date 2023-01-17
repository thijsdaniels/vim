import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'consumption.dart';
import 'performance.dart';

class QuickTrackFoodDialog extends StatefulWidget {
  const QuickTrackFoodDialog({ super.key });

  @override
  State<QuickTrackFoodDialog> createState() => _QuickTrackFoodDialog();
}

class _QuickTrackFoodDialog extends State<QuickTrackFoodDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'Quick Track');
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbohydratesController = TextEditingController(text: '0');
  final TextEditingController _fatController = TextEditingController(text: '0');
  final TextEditingController _proteinController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quick Track Food'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _caloriesController,
              decoration: const InputDecoration(
                labelText: 'Calories',
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _carbohydratesController,
              decoration: const InputDecoration(
                labelText: 'Carbs',
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _fatController,
              decoration: const InputDecoration(
                labelText: 'Fat',
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _proteinController,
              decoration: const InputDecoration(
                labelText: 'Protein',
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Confirm'),
          onPressed: () {
            FormState formState = _formKey.currentState!;
            if (formState.validate()) {
              formState.save();
              Navigator.of(context).pop(
                Consumption(
                  name: _nameController.value.text,
                  calories: int.parse(_caloriesController.value.text),
                  carbohydrates: int.parse(_carbohydratesController.value.text),
                  fat: int.parse(_fatController.value.text),
                  protein: int.parse(_proteinController.value.text),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class QuickTrackExerciseDialog extends StatefulWidget {
  const QuickTrackExerciseDialog({ super.key });

  @override
  State<QuickTrackExerciseDialog> createState() => _QuickTrackExerciseDialog();
}

class _QuickTrackExerciseDialog extends State<QuickTrackExerciseDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'Quick Track');
  final TextEditingController _caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quick Track Exercise'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              onTap: () {},
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name.';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _caloriesController,
              decoration: const InputDecoration(
                labelText: 'Calories',
              ),
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number.';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Confirm'),
          onPressed: () {
            FormState formState = _formKey.currentState!;

            if (formState.validate()) {
              formState.save();

              Navigator.of(context).pop(
                Performance(
                  name: _nameController.value.text,
                  calories: int.parse(_caloriesController.value.text),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}