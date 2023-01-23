import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/recipe.dart';
import 'package:vim/models/recipe_consumption.dart';
import 'package:vim/models/recipes.dart';

class TrackRecipeDialog extends StatefulWidget {
  final RecipeConsumption? recipeConsumption;

  const TrackRecipeDialog({super.key, this.recipeConsumption});

  @override
  State<TrackRecipeDialog> createState() => _TrackRecipeDialogState();
}

class _TrackRecipeDialogState extends State<TrackRecipeDialog> {
  Recipe? _recipe;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.recipeConsumption != null) {
      _amountController.text = widget.recipeConsumption!.amount.toString();

      setState(() {
        _recipe = widget.recipeConsumption!.recipe;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.recipeConsumption != null
          ? widget.recipeConsumption!.name
          : 'Track Recipe'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.recipeConsumption == null)
                Consumer<Recipes>(
                  builder: (context, recipes, child) =>
                      DropdownButtonFormField<Recipe>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Recipe',
                    ),
                    items: List.generate(
                            recipes.length, (index) => recipes.get(index))
                        .map((recipe) => DropdownMenuItem<Recipe>(
                              value: recipe,
                              child: Text(recipe.name),
                            ))
                        .toList(),
                    value: _recipe,
                    onChanged: (recipe) {
                      setState(() {
                        _recipe = recipe;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select an recipe.';
                      }
                      return null;
                    },
                  ),
                ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Grams',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
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

                double amount = double.parse(_amountController.value.text);

                RecipeConsumption? recipeConsumption = widget.recipeConsumption;

                if (recipeConsumption != null) {
                  recipeConsumption.amount = amount;
                } else {
                  recipeConsumption = _recipe?.consumption(
                    timestamp: dateModel.timestamp,
                    amount: amount,
                  );
                }

                Navigator.of(context).pop(recipeConsumption);
              }
            },
          ),
        ),
      ],
    );
  }
}
