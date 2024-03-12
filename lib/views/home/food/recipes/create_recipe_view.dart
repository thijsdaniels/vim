import 'package:flutter/material.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/recipes_collection.dart';
import 'package:vim/widgets/atoms/incremental_number_form_field.dart';
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
  TextEditingController _servings = TextEditingController();

  @override
  void initState() {
    super.initState();

    Recipe? recipe = widget.recipe;

    if (recipe != null) {
      _name = recipe.name;
      _servings.text = recipe.servings.toString();
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
                  recipe.servings = num.parse(_servings.text);

                  RecipesCollection.of(context).update(recipe);
                } else {
                  recipe = Recipe(
                    user: User.of(context).reference!,
                    name: _name,
                    servings: num.parse(_servings.text),
                  );

                  RecipesCollection.of(context).create(recipe);
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
                  IncrementalNumberFormField(
                    decoration: const InputDecoration(
                      labelText: 'Servings',
                    ),
                    controller: _servings,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a number.';
                      }
                      return null;
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
