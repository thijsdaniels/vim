import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient_amount_reference.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/widgets/atoms/ingredient_form_field.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
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
      body: Form(
        key: _formKey,
        child: StandardList(
          children: [
            SimpleCard(
              title: 'Details',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StreamBuilder(
                    stream: _ingredient != null
                        ? IngredientsService.of(context).get(_ingredient!.id)
                        : null,
                    builder: (context, snapshot) => IngredientFormField(
                      selection: snapshot.data,
                      onSelected: (ingredient) {
                        setState(() {
                          _ingredient = ingredient?.reference;
                        });
                      },
                    ),
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
          ],
        ),
      ),
    );
  }
}
