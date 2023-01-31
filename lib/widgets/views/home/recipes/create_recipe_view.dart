import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/ingredient_amounts.dart';
import 'package:vim/models/ingredients.dart';
import 'package:vim/models/recipe.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/widgets/atoms/ingredient_reference_dropdown_menu.dart';

class CreateRecipeView extends StatefulWidget {
  final Recipe? recipe;

  const CreateRecipeView({super.key, this.recipe});

  @override
  State<CreateRecipeView> createState() => _CreateRecipeViewState();
}

class PotentialIngredientAmount {
  DocumentReference? ingredientReference;
  double? amount;

  PotentialIngredientAmount({this.ingredientReference, this.amount});
}

class _CreateRecipeViewState extends State<CreateRecipeView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  int _servings = 1;
  List<PotentialIngredientAmount> _ingredientAmounts = [];

  @override
  void initState() {
    super.initState();

    Recipe? recipe = widget.recipe;

    if (recipe != null) {
      _name = recipe.name;
      _servings = recipe.servings;
      _ingredientAmounts =
          List.generate(recipe.ingredientAmounts.length, (index) {
        var ingredientAmount = recipe.ingredientAmounts.get(index);
        return PotentialIngredientAmount(
          ingredientReference: ingredientAmount.ingredientReference,
          amount: ingredientAmount.amount,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Recipe? recipe = widget.recipe;

    return Scaffold(
      appBar: AppBar(
        title: recipe != null ? Text(recipe.name) : const Text('Create Recipe'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                Recipe? recipe = widget.recipe;

                IngredientAmountsReference ingredientAmounts =
                    IngredientAmountsReference(_ingredientAmounts
                        .map((ingredientAmount) {
                          if (ingredientAmount.ingredientReference != null &&
                              ingredientAmount.amount != null) {
                            return IngredientAmountReference(
                              ingredientReference:
                                  ingredientAmount.ingredientReference!,
                              amount: ingredientAmount.amount!,
                            );
                          }
                        })
                        .whereType<IngredientAmountReference>()
                        .toList());

                if (recipe != null) {
                  recipe.name = _name;
                  recipe.servings = _servings;
                  recipe.ingredientAmounts = ingredientAmounts;

                  RecipesService.update(recipe);
                } else {
                  recipe = Recipe(
                    name: _name,
                    servings: _servings,
                    ingredientAmounts: ingredientAmounts,
                  );

                  RecipesService.create(recipe);
                }

                Navigator.of(context).pop(recipe);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          initialValue: _name,
                          textCapitalization: TextCapitalization.words,
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
                        TextFormField(
                          initialValue: _servings.toString(),
                          autofocus: true,
                          decoration: const InputDecoration(
                            labelText: 'Servings',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                          ],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a number.';
                            }
                            return null;
                          },
                          onChanged: (servings) {
                            setState(() {
                              _servings = int.parse(servings);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ..._ingredientAmounts
                    .asMap()
                    .entries
                    .map(
                      (entry) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              IngredientAmountField(
                                ingredientReference:
                                    entry.value.ingredientReference,
                                onIngredientSelected: (ingredientReference) {
                                  entry.value.ingredientReference =
                                      ingredientReference;
                                  setState(() {
                                    _ingredientAmounts = [
                                      ..._ingredientAmounts
                                    ];
                                  });
                                },
                                amount: entry.value.amount,
                                onAmountChanged: (amount) {
                                  entry.value.amount = amount;
                                  setState(() {
                                    _ingredientAmounts = [
                                      ..._ingredientAmounts
                                    ];
                                  });
                                },
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    child: const Text('Remove'),
                                    onPressed: () {
                                      _ingredientAmounts.removeAt(entry.key);
                                      setState(() {
                                        _ingredientAmounts = [
                                          ..._ingredientAmounts
                                        ];
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      child: const Text('Add Ingredient'),
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
      ),
    );
  }
}

class IngredientAmountField extends StatefulWidget {
  final DocumentReference? ingredientReference;
  final double? amount;
  final void Function(DocumentReference?) onIngredientSelected;
  final void Function(double) onAmountChanged;

  const IngredientAmountField({
    super.key,
    this.ingredientReference,
    this.amount,
    required this.onIngredientSelected,
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
        IngredientReferenceDropdownMenu(
          initialSelection: widget.ingredientReference,
          onSelected: widget.onIngredientSelected,
        ),
        const SizedBox(height: 16),
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
              widget.onAmountChanged(double.parse(amount)),
        ),
      ],
    );
  }
}
