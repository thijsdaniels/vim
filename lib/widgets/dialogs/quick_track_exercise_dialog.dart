import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/performance.dart';

class QuickTrackExerciseDialog extends StatefulWidget {
  final Performance? performance;

  const QuickTrackExerciseDialog({super.key, this.performance});

  @override
  State<QuickTrackExerciseDialog> createState() =>
      _QuickTrackExerciseDialogState();
}

class _QuickTrackExerciseDialogState extends State<QuickTrackExerciseDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Quick Track');
  final TextEditingController _caloriesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.performance != null) {
      _nameController.text = widget.performance!.name;
      _caloriesController.text = widget.performance!.calories.toString();
    }
  }

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
        Consumer<DateModel>(
          builder: (context, dateModel, child) => TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Confirm'),
            onPressed: () {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                String name = _nameController.value.text;
                int calories = int.parse(_caloriesController.value.text);

                Performance? performance = widget.performance;

                if (performance != null) {
                  performance.name = name;
                  performance.calories = calories;
                } else {
                  performance = Performance(
                    timestamp: dateModel.timestamp,
                    name: name,
                    calories: calories,
                  );
                }

                Navigator.of(context).pop(performance);
              }
            },
          ),
        ),
      ],
    );
  }
}
