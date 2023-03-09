import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/widgets/atoms/ingredient_dropdown_menu.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/unit_dropdown_menu.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

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
      _ingredient = ingredientConsumption.ingredient;
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
            : const Text('Consume Ingredient'),
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
            child: SimpleCard(
              title: 'Details',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: UnitDropdownMenu(
                          value: _unit,
                          onChanged: (unit) {
                            _unit = unit;
                          },
                          validator: (unit) {
                            if (unit == Unit.servings &&
                                _ingredient?.serving == null) {
                              return "Serving size not defined.";
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: NumberFormField(
                          initialValue: _amount,
                          onChanged: (amount) => setState(() {
                            _amount = amount;
                          }),
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                          ),
                          textInputAction: TextInputAction.done,
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
    );
  }
}
