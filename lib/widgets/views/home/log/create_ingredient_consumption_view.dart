import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/amount.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/ingredient_consumption.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/widgets/atoms/ingredient_dropdown_menu.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/unit_dropdown_menu.dart';

class CreateIngredientConsumptionView extends StatefulWidget {
  final IngredientConsumption? ingredientConsumption;

  const CreateIngredientConsumptionView(
      {super.key, this.ingredientConsumption});

  @override
  State<CreateIngredientConsumptionView> createState() =>
      _CreateIngredientConsumptionViewState();
}

class _CreateIngredientConsumptionViewState
    extends State<CreateIngredientConsumptionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Ingredient? _ingredient;
  num? _amount;
  Unit? _unit = Unit.grams;

  @override
  void initState() {
    super.initState();

    IngredientConsumption? ingredientConsumption = widget.ingredientConsumption;

    if (ingredientConsumption != null) {
      _amount = ingredientConsumption.amount.value;
      _unit = ingredientConsumption.amount.unit;
    }
  }

  @override
  Widget build(BuildContext context) {
    IngredientConsumption? ingredientConsumption = widget.ingredientConsumption;

    return Scaffold(
      appBar: AppBar(
        title: ingredientConsumption != null
            ? Text(ingredientConsumption.name)
            : const Text('Track Ingredient'),
        actions: [
          Consumer<DateModel>(
            builder: (context, dateModel, _) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                FormState formState = _formKey.currentState!;

                if (formState.validate()) {
                  formState.save();

                  IngredientConsumption? ingredientConsumption =
                      widget.ingredientConsumption;

                  if (ingredientConsumption != null) {
                    ingredientConsumption.amount = Amount(
                      value: _amount!,
                      unit: _unit!,
                    );

                    ConsumptionsService.update(ingredientConsumption);
                  } else {
                    ingredientConsumption = _ingredient?.consumption(
                      timestamp: dateModel.timestamp,
                      amount: Amount(
                        value: _amount!,
                        unit: _unit!,
                      ),
                    );

                    if (ingredientConsumption != null) {
                      ConsumptionsService.create(ingredientConsumption);
                    }
                  }

                  Navigator.of(context).pop(ingredientConsumption);
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.ingredientConsumption == null)
                      IngredientDropdownMenu(
                        initialSelection: _ingredient,
                        onSelected: (Ingredient? ingredient) {
                          setState(() {
                            _ingredient = ingredient;
                            if (ingredient?.serving == null) {
                              _unit = Unit.grams;
                            }
                          });
                        },
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: UnitDropdownMenu(
                            value: _unit,
                            items: [
                              Unit.grams,
                              if (_ingredient?.serving != null) Unit.servings,
                            ],
                            onChanged: (unit) {
                              _unit = unit;
                            },
                          ),
                        ),
                        Expanded(
                          child: NumberFormField(
                            initialValue: _amount,
                            onChanged: (amount) => setState(() {
                              _amount = amount;
                            }),
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
