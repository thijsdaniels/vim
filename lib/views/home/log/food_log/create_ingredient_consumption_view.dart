import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/ingredient_consumption.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/consumptions_collection.dart';
import 'package:vim/widgets/atoms/incremental_number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/unit_dropdown_menu.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateIngredientConsumptionView extends StatefulWidget {
  final IngredientConsumption? ingredientConsumption;
  final Ingredient? ingredient;

  Ingredient get _ingredient =>
      ingredientConsumption?.ingredient.snapshot ?? ingredient!;

  const CreateIngredientConsumptionView({
    super.key,
    this.ingredientConsumption,
    this.ingredient,
  }) : assert(ingredientConsumption != null || ingredient != null);

  @override
  State<CreateIngredientConsumptionView> createState() =>
      _CreateIngredientConsumptionViewState();
}

class _CreateIngredientConsumptionViewState
    extends State<CreateIngredientConsumptionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _timeController = TextEditingController();

  Timestamp? _timestamp;
  num? _amount;
  Unit? _unit = Unit.grams;

  @override
  void initState() {
    super.initState();

    IngredientConsumption? ingredientConsumption = widget.ingredientConsumption;

    if (ingredientConsumption != null) {
      _timestamp = ingredientConsumption.timestamp;
      _amount = ingredientConsumption.amount.value;
      _unit = ingredientConsumption.amount.unit;
    } else {
      if (widget.ingredient!.serving != null) {
        _unit = Unit.servings;
        _amount = 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = _timestamp ?? DateModel.of(context).timestamp;
    IngredientConsumption? ingredientConsumption = widget.ingredientConsumption;

    return Scaffold(
      appBar: AppBar(
        title: ingredientConsumption != null
            ? Text(ingredientConsumption.name)
            : Text(widget.ingredient!.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                IngredientConsumption? ingredientConsumption =
                    widget.ingredientConsumption;

                if (ingredientConsumption != null) {
                  ingredientConsumption.timestamp = timestamp;
                  ingredientConsumption.amount = Amount(
                    value: _amount!,
                    unit: _unit!,
                  );

                  ConsumptionsCollection.of(context)
                      .update(ingredientConsumption);
                } else {
                  ingredientConsumption = widget.ingredient?.consumption(
                    user: User.of(context),
                    timestamp: timestamp,
                    amount: Amount(
                      value: _amount!,
                      unit: _unit!,
                    ),
                  );

                  if (ingredientConsumption != null) {
                    ConsumptionsCollection.of(context)
                        .create(ingredientConsumption);
                  }
                }

                Navigator.of(context).pop(ingredientConsumption);
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
              title: 'Timestamp',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            label: Text("Date"),
                          ),
                          initialValue: timestamp.toDate().toDateString(),
                          enabled: false,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          initialValue: _timeController.text.isEmpty
                              ? TimeOfDay.fromDateTime(timestamp.toDate())
                                  .format(context)
                              : null,
                          controller: _timeController.text.isEmpty
                              ? null
                              : _timeController,
                          decoration: const InputDecoration(
                            label: Text("Time"),
                          ),
                          readOnly: true,
                          onTap: () async {
                            TimeOfDay? timeOfDay = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(
                                timestamp.toDate(),
                              ),
                            );

                            if (timeOfDay != null) {
                              var newDateTime = timestamp.toDate().withTime(
                                    timeOfDay.hour,
                                    timeOfDay.minute,
                                  );

                              var newTimestamp = Timestamp.fromDate(
                                newDateTime,
                              );

                              setState(() {
                                _timestamp = newTimestamp;
                                _timeController.text =
                                    TimeOfDay.fromDateTime(newDateTime)
                                        .format(context);
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SimpleCard(
              title: 'Quantity',
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: UnitDropdownMenu(
                          value: _unit,
                          items: [
                            Unit.grams,
                            if (widget._ingredient.serving != null)
                              Unit.servings,
                          ],
                          onChanged: (unit) {
                            _unit = unit;
                          },
                          validator: (unit) {
                            if (unit == Unit.servings &&
                                widget._ingredient.serving == null) {
                              return "Serving size not defined.";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: IncrementalNumberFormField(
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            hintText:
                                _unit == Unit.servings ? 'Servings' : 'Grams',
                          ),
                          initialValue: _amount,
                          onChanged: (amount) => setState(() {
                            _amount = amount;
                          }),
                          autofocus: true,
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
          ],
        ),
      ),
    );
  }
}
