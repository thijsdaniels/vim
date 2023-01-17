import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/performance.dart';

class QuickTrackExerciseDialog extends StatefulWidget {
  const QuickTrackExerciseDialog({ super.key });

  @override
  State<QuickTrackExerciseDialog> createState() => _QuickTrackExerciseDialogState();
}

class _QuickTrackExerciseDialogState extends State<QuickTrackExerciseDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: 'Quick Track');
  final TextEditingController _caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quick Track Exercise'),
      content: SingleChildScrollView(
        child: Form(
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
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Calories',
                ),
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