import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/ingredient_amounts.dart';
import 'package:vim/models/ingredients.dart';
import 'package:vim/models/recipe.dart';

class CreateRecipeDialog extends StatefulWidget {
  final Recipe? recipe;

  const CreateRecipeDialog({super.key, this.recipe});

  @override
  State<CreateRecipeDialog> createState() => _CreateRecipeDialogState();
}

class PotentialIngredientAmount {
  Ingredient? ingredient;
  num? amount;

  PotentialIngredientAmount({this.ingredient, this.amount});
}

class _CreateRecipeDialogState extends State<CreateRecipeDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  List<PotentialIngredientAmount> _ingredientAmounts = [];

  @override
  void initState() {
    super.initState();

    Recipe? recipe = widget.recipe;

    if (recipe != null) {
      _name = recipe.name;
      _ingredientAmounts =
          List.generate(recipe.ingredientAmounts.length, (index) {
        var ingredientAmount = recipe.ingredientAmounts.get(index);
        return PotentialIngredientAmount(
          ingredient: ingredientAmount.ingredient,
          amount: ingredientAmount.amount,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Recipe'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                initialValue: _name,
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
                onChanged: (name) {
                  setState(() {
                    _name = name;
                  });
                },
              ),
              const SizedBox(height: 16),
              ..._ingredientAmounts
                  .asMap()
                  .entries
                  .map(
                    (entry) => Column(
                      children: [
                        IngredientAmountField(
                          ingredient: entry.value.ingredient,
                          onIngredientChanged: (ingredient) {
                            entry.value.ingredient = ingredient;
                            setState(() {
                              _ingredientAmounts = [..._ingredientAmounts];
                            });
                          },
                          amount: entry.value.amount,
                          onAmountChanged: (amount) {
                            entry.value.amount = amount;
                            setState(() {
                              _ingredientAmounts = [..._ingredientAmounts];
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            _ingredientAmounts.removeAt(entry.key);
                            setState(() {
                              _ingredientAmounts = [..._ingredientAmounts];
                            });
                          },
                        )
                      ],
                    ),
                  )
                  .toList(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      _ingredientAmounts.add(PotentialIngredientAmount());
                      setState(() {
                        _ingredientAmounts = [..._ingredientAmounts];
                      });
                    },
                  ),
                ],
              )
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

              Recipe? recipe = widget.recipe;

              IngredientAmounts ingredientAmounts =
                  IngredientAmounts(_ingredientAmounts
                      .map((ingredientAmount) {
                        if (ingredientAmount.ingredient != null &&
                            ingredientAmount.amount != null) {
                          return IngredientAmount(
                            ingredient: ingredientAmount.ingredient!,
                            amount: ingredientAmount.amount!,
                          );
                        }
                      })
                      .whereType<IngredientAmount>()
                      .toList());

              if (recipe != null) {
                recipe.name = _name;
                recipe.ingredientAmounts = ingredientAmounts;
              } else {
                recipe = Recipe(
                  name: _name,
                  ingredientAmounts: ingredientAmounts,
                );
              }

              Navigator.of(context).pop(recipe);
            }
          },
        ),
      ],
    );
  }
}

class IngredientAmountField extends StatefulWidget {
  final Ingredient? ingredient;
  final num? amount;
  final void Function(Ingredient?) onIngredientChanged;
  final void Function(num) onAmountChanged;

  const IngredientAmountField({
    super.key,
    this.ingredient,
    this.amount,
    required this.onIngredientChanged,
    required this.onAmountChanged,
  });

  @override
  State<StatefulWidget> createState() => _IngredientAmountField();
}

class _IngredientAmountField extends State<IngredientAmountField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<Ingredients>(
          builder: (context, ingredients, child) =>
              DropdownButtonFormField<Ingredient>(
            decoration: const InputDecoration(
              labelText: 'Ingredient',
            ),
            items: List.generate(
                    ingredients.length, (index) => ingredients.get(index))
                .map((ingredient) => DropdownMenuItem<Ingredient>(
                      value: ingredient,
                      child: Text(ingredient.name),
                    ))
                .toList(),
            value: widget.ingredient,
            validator: (value) {
              if (value == null) {
                return 'Please select an ingredient.';
              }
              return null;
            },
            onChanged: widget.onIngredientChanged,
            isExpanded: true,
          ),
        ),
        TextFormField(
          initialValue: widget.amount?.toString() ?? "",
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
          onChanged: (String amount) =>
              widget.onAmountChanged(num.parse(amount)),
        ),
      ],
    );
  }
}
