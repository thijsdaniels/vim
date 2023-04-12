import 'package:flutter/material.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
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

  @override
  void initState() {
    super.initState();

    Recipe? recipe = widget.recipe;

    if (recipe != null) {
      _name = recipe.name;
      _servings = recipe.servings;
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

                if (recipe != null) {
                  recipe.name = _name;
                  recipe.servings = _servings!;

                  RecipesService.update(recipe);
                } else {
                  recipe = Recipe(
                    name: _name,
                    servings: _servings!,
                  );

                  RecipesService.create(recipe);
                }

                Navigator.of(context).pop(recipe);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: StandardList(
          children: [
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
          ],
        ),
      ),
    );
  }
}
