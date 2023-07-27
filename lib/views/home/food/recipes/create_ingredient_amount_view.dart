import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/food/ingredient_amount.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/ingredients_collection_group.dart';
import 'package:vim/widgets/atoms/ingredient_form_field.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateIngredientAmountView extends StatefulWidget {
  final IngredientAmount? ingredientAmount;

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

  // TODO: Turn this into a `DocumentReference<Ingredient>`.
  DocumentReference? _ingredient;
  num? _amount;

  @override
  void initState() {
    super.initState();

    IngredientAmount? ingredientAmount = widget.ingredientAmount;

    if (ingredientAmount != null) {
      _ingredient = ingredientAmount.ingredientReference;
      _amount = ingredientAmount.amount;
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = User.of(context);

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
                  IngredientAmount(
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
                    stream: IngredientsCollectionGroup.instance.all(
                      users: [user.reference!, ...user.following],
                    ),

                    /// TODO: Figure out a way to get rid of the
                    /// `CircularProgressIndicator`. Doing so currently causes
                    /// an assertion error.
                    builder: (context, ingredients) => ingredients.hasData
                        ? IngredientFormField(
                            ingredients: ingredients.data!,
                            selection: ingredients.data?.firstWhereOrNull(
                              (ingredient) =>
                                  ingredient.reference?.path ==
                                  _ingredient?.path,
                            ),
                            onSelected: (ingredient) {
                              setState(() {
                                _ingredient = ingredient?.reference;
                              });
                            },
                          )
                        : const CircularProgressIndicator(),
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
