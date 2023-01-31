import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/amount.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/recipe.dart';
import 'package:vim/models/recipe_consumption.dart';
import 'package:vim/models/recipes.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/recipe_dropdown_menu.dart';
import 'package:vim/widgets/atoms/unit_dropdown_menu.dart';

class CreateRecipeConsumptionView extends StatefulWidget {
  final RecipeConsumption? recipeConsumption;

  const CreateRecipeConsumptionView({super.key, this.recipeConsumption});

  @override
  State<CreateRecipeConsumptionView> createState() =>
      _CreateRecipeConsumptionViewState();
}

class _CreateRecipeConsumptionViewState
    extends State<CreateRecipeConsumptionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Recipe? _recipe;
  Unit? _unit = Unit.servings;
  double? _amount = 1;

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
    RecipeConsumption? recipeConsumption = widget.recipeConsumption;

    return Scaffold(
      appBar: AppBar(
        title: recipeConsumption != null
            ? Text(recipeConsumption.name)
            : const Text('Track Recipe'),
        actions: [
          Consumer<DateModel>(
            builder: (context, dateModel, child) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                final navigator = Navigator.of(context);

                FormState formState = _formKey.currentState!;

                if (formState.validate()) {
                  formState.save();

                  RecipeConsumption? recipeConsumption =
                      widget.recipeConsumption;

                  if (recipeConsumption != null) {
                    recipeConsumption.amount =
                        Amount(unit: _unit!, value: _amount!);

                    ConsumptionsService.update(recipeConsumption);
                  } else {
                    recipeConsumption = await _recipe?.consumption(
                      timestamp: dateModel.timestamp,
                      amount: Amount(unit: _unit!, value: _amount!),
                    );

                    if (recipeConsumption != null) {
                      ConsumptionsService.create(recipeConsumption);
                    }
                  }

                  navigator.pop(recipeConsumption);
                }
              },
            ),
          )
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
                if (widget.recipeConsumption == null)
                  RecipeDropdownMenu(
                    initialSelection: _recipe,
                    onSelected: (recipe) {
                      setState(() {
                        _recipe = recipe;
                      });
                    },
                  ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: UnitDropdownMenu(
                        initialSelection: Unit.servings,
                        onSelected: (unit) {
                          setState(() {
                            _unit = unit;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: NumberFormField(
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
