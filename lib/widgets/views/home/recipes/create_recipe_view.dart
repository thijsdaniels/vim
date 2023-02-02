import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient_amounts.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/widgets/atoms/ingredient_reference_dropdown_menu.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateRecipeView extends StatefulWidget {
  final Recipe? recipe;

  const CreateRecipeView({super.key, this.recipe});

  @override
  State<CreateRecipeView> createState() => _CreateRecipeViewState();
}

class _CreateRecipeViewState extends State<CreateRecipeView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  num? _servings = 1;
  List<Map<String, dynamic>> _ingredientAmounts = [
    {'ingredient': null, 'amount': null},
  ];

  @override
  void initState() {
    super.initState();

    Recipe? recipe = widget.recipe;

    if (recipe != null) {
      _name = recipe.name;
      _servings = recipe.servings;
      _ingredientAmounts = recipe.ingredientAmounts.toMap();
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

                IngredientAmountsReference ingredientAmounts =
                    IngredientAmountsReference.fromMap(_ingredientAmounts);

                Recipe? recipe = widget.recipe;

                if (recipe != null) {
                  recipe.name = _name;
                  recipe.servings = _servings!;
                  recipe.ingredientAmounts = ingredientAmounts;

                  RecipesService.update(recipe);
                } else {
                  recipe = Recipe(
                    name: _name,
                    servings: _servings!,
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
                SimpleCard(
                  title: 'Details',
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        initialValue: _name,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        textInputAction: TextInputAction.next,
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
                      NumberFormField(
                        initialValue: _servings,
                        autofocus: true,
                        decoration: const InputDecoration(
                          labelText: 'Servings',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter a number.';
                          }
                          return null;
                        },
                        onChanged: (servings) {
                          setState(() {
                            _servings = servings;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                SimpleCard(
                  title: 'Ingredients',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ..._ingredientAmounts.asMap().entries.map(
                        (entry) {
                          return Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: IngredientReferenceDropdownMenu(
                                      initialSelection:
                                          entry.value['ingredient'],
                                      onSelected: (ingredient) {
                                        setState(() {
                                          entry.value['ingredient'] =
                                              ingredient;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: NumberFormField(
                                      initialValue: entry.value['amount'],
                                      decoration: const InputDecoration(
                                        labelText: 'Amount',
                                        hintText: 'Grams',
                                      ),
                                      textInputAction: TextInputAction.done,
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please enter an amount.';
                                        }
                                        return null;
                                      },
                                      onChanged: (amount) {
                                        setState(() {
                                          entry.value['amount'] = amount;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: _ingredientAmounts.length > 1
                                        ? () {
                                            setState(() {
                                              _ingredientAmounts
                                                  .removeAt(entry.key);
                                            });
                                          }
                                        : null,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text('Add Ingredient'),
                          onPressed: () {
                            setState(() {
                              _ingredientAmounts.add({
                                'ingredient': null,
                                'amount': null,
                              });
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
