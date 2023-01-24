import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/amount.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/recipe.dart';
import 'package:vim/models/recipe_consumption.dart';
import 'package:vim/models/recipes.dart';
import 'package:vim/widgets/form_fields/number_form_field.dart';

class TrackRecipeDialog extends StatefulWidget {
  final RecipeConsumption? recipeConsumption;

  const TrackRecipeDialog({super.key, this.recipeConsumption});

  @override
  State<TrackRecipeDialog> createState() => _TrackRecipeDialogState();
}

class _TrackRecipeDialogState extends State<TrackRecipeDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Recipe? _recipe;
  Unit? _unit = Unit.servings;
  num? _amount = 1;

  @override
  void initState() {
    super.initState();

    RecipeConsumption? recipeConsumption = widget.recipeConsumption;

    if (recipeConsumption != null) {
      _unit = recipeConsumption.amount.unit;
      _amount = recipeConsumption.amount.value;
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
                        .map(
                          (recipe) => DropdownMenuItem<Recipe>(
                            value: recipe,
                            child: Text(recipe.name),
                          ),
                        )
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
              DropdownButtonFormField<Unit>(
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Unit',
                ),
                items: Unit.values
                    .map(
                      (unit) => DropdownMenuItem<Unit>(
                        value: unit,
                        child: Text(describeEnum(unit).toTitleCase()),
                      ),
                    )
                    .toList(),
                value: _unit,
                onChanged: (unit) {
                  setState(() {
                    _unit = unit;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a unit.';
                  }
                  return null;
                },
              ),
              NumberFormField(
                initialValue: _amount,
                onChanged: (amount) {
                  setState(() {
                    _amount = amount;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
                validator: (value) {
                  if (value == null) {
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
            onPressed: () async {
              final navigator = Navigator.of(context);

              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                RecipeConsumption? recipeConsumption = widget.recipeConsumption;

                if (recipeConsumption != null) {
                  recipeConsumption.amount =
                      Amount(unit: _unit!, value: _amount!);
                } else {
                  recipeConsumption = await _recipe?.consumption(
                    timestamp: dateModel.timestamp,
                    amount: Amount(unit: _unit!, value: _amount!),
                  );
                }

                navigator.pop(recipeConsumption);
              }
            },
          ),
        ),
      ],
    );
  }
}
