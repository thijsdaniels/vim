import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vim/models/ingredient.dart';
import 'package:vim/models/ingredient_consumption.dart';

class TrackIngredientDialog extends StatefulWidget {
  final IngredientConsumption? ingredientConsumption;

  const TrackIngredientDialog({super.key, this.ingredientConsumption});

  @override
  State<TrackIngredientDialog> createState() => _TrackIngredientDialogState();
}

class _TrackIngredientDialogState extends State<TrackIngredientDialog> {
  List<Ingredient> _ingredients = [];
  Ingredient? _ingredient;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.ingredientConsumption != null) {
      _amountController.text = widget.ingredientConsumption!.amount.toString();

      setState(() {
        _ingredient = widget.ingredientConsumption!.ingredient;
      });
    }

    _loadIngredients();
  }

  void _loadIngredients() async {
    List<Ingredient> ingredients = await Ingredient.all();

    setState(() {
      _ingredients = ingredients;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.ingredientConsumption != null
          ? widget.ingredientConsumption!.name
          : 'Track Ingredient'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (widget.ingredientConsumption == null)
                DropdownButtonFormField<Ingredient>(
                  decoration: const InputDecoration(
                    labelText: 'Ingredient',
                  ),
                  items: _ingredients
                      .map((ingredient) => DropdownMenuItem<Ingredient>(
                            value: ingredient,
                            child: Text(ingredient.name),
                          ))
                      .toList(),
                  value: _ingredient,
                  onChanged: (ingredient) {
                    setState(() {
                      _ingredient = ingredient;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an ingredient.';
                    }
                    return null;
                  },
                ),
              TextFormField(
                controller: _amountController,
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
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Confirm'),
          onPressed: () {
            FormState formState = _formKey.currentState!;

            if (formState.validate()) {
              formState.save();

              double amount = double.parse(_amountController.value.text);

              Navigator.of(context).pop(
                _ingredient?.consumption(amount),
              );
            }
          },
        ),
      ],
    );
  }
}
