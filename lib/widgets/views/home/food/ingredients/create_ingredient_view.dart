import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/widgets/atoms/icons8_icon_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/switch_form_field.dart';
import 'package:vim/widgets/molecules/nutrition_form_fields.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateIngredientView extends StatefulWidget {
  final Ingredient? ingredient;

  const CreateIngredientView({super.key, this.ingredient});

  @override
  State<CreateIngredientView> createState() => _CreateIngredientViewState();
}

class _CreateIngredientViewState extends State<CreateIngredientView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _icon;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _servingController = TextEditingController();
  bool _nutritionPerServing = false;
  final NutritionEditingController _nutritionController =
      NutritionEditingController();

  @override
  void initState() {
    super.initState();

    Ingredient? ingredient = widget.ingredient;

    if (ingredient != null) {
      _icon = ingredient.icon;
      _nameController.text = ingredient.name;
      _brandController.text = ingredient.brand ?? "";
      _servingController.text = ingredient.serving?.toString() ?? "";
      _nutritionPerServing = ingredient.nutritionPerServing;
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

                num? serving = _servingController.value.text.isNotEmpty
                    ? num.parse(_servingController.value.text)
                    : null;

                Nutrition nutrition = _nutritionController.nutrition;

                Ingredient? ingredient = widget.ingredient;

                if (ingredient != null) {
                  ingredient.icon = _icon;
                  ingredient.name = name;
                  ingredient.brand = brand;
                  ingredient.serving = serving;
                  ingredient.nutritionPerServing = _nutritionPerServing;
                  ingredient.nutrition = nutrition;

                  IngredientsService.instance.update(ingredient);
                } else {
                  ingredient = Ingredient(
                    icon: _icon,
                    name: name,
                    brand: brand,
                    serving: serving,
                    nutrition: nutrition,
                    nutritionPerServing: _nutritionPerServing,
                  );

                  IngredientsService.instance.create(ingredient);
                }

                Navigator.of(context).pop(ingredient);
              }
            },
          )
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
                  Icons8IconFormField(
                    selection: _icon,
                    onSelected: (String? icon) {
                      setState(() {
                        _icon = icon;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    autofocus: true,
                    controller: _nameController,
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
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _brandController,
                    textCapitalization: TextCapitalization.words,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _servingController,
                    decoration: const InputDecoration(
                      labelText: 'Serving',
                      hintText: 'Grams',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9\.]'))
                    ],
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),
            ),
            SimpleCard(
              title: 'Nutrition',
              child: Column(
                children: [
                  SwitchFormField(
                    label: const Text('Per Serving'),
                    value: _nutritionPerServing,
                    onChanged: (perServing) {
                      setState(() {
                        _nutritionPerServing = perServing;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  NutritionFormFields(
                    controller: _nutritionController,
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
