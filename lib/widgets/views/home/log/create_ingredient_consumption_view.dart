import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/amount.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/ingredient_consumption.dart';
import 'package:vim/models/ingredients.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/widgets/atoms/ingredient_dropdown_menu.dart';
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
  Ingredient? _ingredient;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.ingredientConsumption != null) {
      _amountController.text = widget.ingredientConsumption!.amount.toString();
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

                  double amount = double.parse(_amountController.value.text);

                  IngredientConsumption? ingredientConsumption =
                      widget.ingredientConsumption;

                  if (ingredientConsumption != null) {
                    ingredientConsumption.amount = amount;
                    ConsumptionsService.update(ingredientConsumption);
                  } else {
                    ingredientConsumption = _ingredient?.consumption(
                      timestamp: dateModel.timestamp,
                      amount: amount,
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
                          });
                        },
                      ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: UnitDropdownMenu(
                            onSelected: (unit) {
                              // TODO
                            },
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _amountController,
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9\.]'))
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
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
