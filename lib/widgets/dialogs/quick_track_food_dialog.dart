import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/consumption.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/nutrition.dart';

class QuickTrackFoodDialog extends StatefulWidget {
  final Consumption? consumption;

  const QuickTrackFoodDialog({super.key, this.consumption});

  @override
  State<QuickTrackFoodDialog> createState() => _QuickTrackFoodDialogState();
}

class _QuickTrackFoodDialogState extends State<QuickTrackFoodDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Quick Track');
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbohydratesController =
      TextEditingController(text: '0');
  final TextEditingController _fatController = TextEditingController(text: '0');
  final TextEditingController _proteinController =
      TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();

    if (widget.consumption != null) {
      _nameController.text = widget.consumption!.name;
      _caloriesController.text =
          widget.consumption!.nutrition.calories.toString();
      _carbohydratesController.text =
          widget.consumption!.nutrition.carbohydrates.toString();
      _fatController.text = widget.consumption!.nutrition.fat.toString();
      _proteinController.text =
          widget.consumption!.nutrition.protein.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Quick Track Food'),
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
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
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
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
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
                Nutrition nutrition = Nutrition(
                  calories: double.parse(_caloriesController.value.text),
                  carbohydrates:
                      double.parse(_carbohydratesController.value.text),
                  fat: double.parse(_fatController.value.text),
                  protein: double.parse(_proteinController.value.text),
                );

                Consumption? consumption = widget.consumption;

                if (consumption != null) {
                  consumption.name = name;
                  consumption.nutrition = nutrition;
                } else {
                  consumption = Consumption(
                    timestamp: dateModel.timestamp,
                    name: name,
                    nutrition: nutrition,
                  );
                }

                Navigator.of(context).pop(consumption);
              }
            },
          ),
        ),
      ],
    );
  }
}
