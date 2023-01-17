import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/consumption.dart';
import '../models/ingredient.dart';

class TrackIngredientDialog extends StatefulWidget {
  const TrackIngredientDialog({ super.key });

  @override
  State<TrackIngredientDialog> createState() => _TrackIngredientDialogState();
}

class _TrackIngredientDialogState extends State<TrackIngredientDialog> {
  List<Ingredient> _ingredients = [];
  Ingredient? _ingredient;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  _TrackIngredientDialogState() {
    _initialize();
  }

  void _initialize() async {
    List<Ingredient> ingredients = await Ingredient.all();

    setState(() {
      _ingredients = ingredients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Track Ingredient'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButtonFormField<Ingredient>(
                decoration: const InputDecoration(
                  labelText: 'Ingredient',
                ),
                items: _ingredients.map((ingredient) => DropdownMenuItem<Ingredient>(
                  value: ingredient,
                  child: Text(ingredient.name),
                )).toList(),
                value: _ingredient,
                onChanged: (ingredient) {
                  setState(() {
                    _ingredient = ingredient;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select an ingredient.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Grams',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount.';
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

              double amount = double.parse(_amountController.value.text);

              Navigator.of(context).pop(
                _ingredient?.consumption(amount),
              );
            }
          },
        ),
      ],
    );
  }
}
