import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient_amounts.dart';
import 'package:vim/widgets/atoms/ingredient_reference_dropdown_menu.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateIngredientAmountView extends StatefulWidget {
  final IngredientAmountReference? ingredientAmount;

  const CreateIngredientAmountView({
    super.key,
    this.ingredientAmount,
  });

  @override
  State<CreateIngredientAmountView> createState() =>
      _CreateIngredientAmountViewState();
}

class _CreateIngredientAmountViewState
    extends State<CreateIngredientAmountView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DocumentReference? _ingredient;
  num? _amount;

  @override
  void initState() {
    super.initState();

    IngredientAmountReference? ingredientAmount = widget.ingredientAmount;

    if (ingredientAmount != null) {
      _ingredient = ingredientAmount.ingredientReference;
      _amount = ingredientAmount.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Ingredient'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                Navigator.of(context).pop(
                  IngredientAmountReference(
                    ingredientReference: _ingredient!,
                    amount: _amount!,
                  ),
                );
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
            child: SimpleCard(
              title: 'Details',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IngredientReferenceDropdownMenu(
                    initialSelection: _ingredient,
                    onSelected: (DocumentReference? ingredient) {
                      setState(() {
                        _ingredient = ingredient;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  NumberFormField(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
