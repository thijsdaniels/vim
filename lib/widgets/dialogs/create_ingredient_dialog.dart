import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/nutrition.dart';

class CreateIngredientDialog extends StatefulWidget {
  final Ingredient? ingredient;

  const CreateIngredientDialog({super.key, this.ingredient});

  @override
  State<CreateIngredientDialog> createState() => _CreateIngredientDialogState();
}

class _CreateIngredientDialogState extends State<CreateIngredientDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _carbohydratesController =
      TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.ingredient != null) {
      _nameController.text = widget.ingredient!.name;
      _brandController.text = widget.ingredient!.brand ?? "";
      _caloriesController.text =
          widget.ingredient!.nutrition.calories.toString();
      _carbohydratesController.text =
          widget.ingredient!.nutrition.carbohydrates.toString();
      _fatController.text = widget.ingredient!.nutrition.fat.toString();
      _proteinController.text = widget.ingredient!.nutrition.protein.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Ingredient'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                autofocus: true,
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
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Brand',
                ),
              ),
              TextFormField(
                controller: _caloriesController,
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
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Confirm'),
          onPressed: () {
            FormState formState = _formKey.currentState!;

            if (formState.validate()) {
              formState.save();

              String name = _nameController.value.text;
              String? brand = _brandController.value.text.isNotEmpty
                  ? _brandController.value.text
                  : null;
              Nutrition nutrition = Nutrition(
                calories: double.parse(_caloriesController.value.text),
                carbohydrates:
                    double.parse(_carbohydratesController.value.text),
                fat: double.parse(_fatController.value.text),
                protein: double.parse(_proteinController.value.text),
              );

              Ingredient? ingredient = widget.ingredient;

              if (ingredient != null) {
                ingredient.name = name;
                ingredient.brand = brand;
                ingredient.nutrition = nutrition;
              } else {
                Ingredient(
                  name: name,
                  brand: brand,
                  nutrition: nutrition,
                );
              }

              Navigator.of(context).pop(ingredient);
            }
          },
        ),
      ],
    );
  }
}
