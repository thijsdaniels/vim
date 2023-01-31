import 'package:flutter/material.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/nutrition.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/widgets/molecules/nutrition_form_fields.dart';

class CreateIngredientView extends StatefulWidget {
  final Ingredient? ingredient;

  const CreateIngredientView({super.key, this.ingredient});

  @override
  State<CreateIngredientView> createState() => _CreateIngredientViewState();
}

class _CreateIngredientViewState extends State<CreateIngredientView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final NutritionEditingController _nutritionController =
      NutritionEditingController();

  @override
  void initState() {
    super.initState();

    Ingredient? ingredient = widget.ingredient;

    if (ingredient != null) {
      _nameController.text = ingredient.name;
      _brandController.text = ingredient.brand ?? "";
      _nutritionController.nutrition = ingredient.nutrition;
    }
  }

  @override
  Widget build(BuildContext context) {
    Ingredient? ingredient = widget.ingredient;

    return Scaffold(
      appBar: AppBar(
        title: ingredient != null
            ? Text(ingredient.name)
            : const Text('Create Ingredient'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                String name = _nameController.value.text;

                String? brand = _brandController.value.text.isNotEmpty
                    ? _brandController.value.text
                    : null;

                Nutrition nutrition = _nutritionController.nutrition;

                Ingredient? ingredient = widget.ingredient;

                if (ingredient != null) {
                  ingredient.name = name;
                  ingredient.brand = brand;
                  ingredient.nutrition = nutrition;

                  IngredientsService.update(ingredient);
                } else {
                  ingredient = Ingredient(
                    name: name,
                    brand: brand,
                    nutrition: nutrition,
                  );

                  IngredientsService.create(ingredient);
                }

                Navigator.of(context).pop(ingredient);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          autofocus: true,
                          controller: _nameController,
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
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _brandController,
                          textCapitalization: TextCapitalization.words,
                          decoration: const InputDecoration(
                            labelText: 'Brand',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: NutritionFormFields(
                      controller: _nutritionController,
                    ),
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
