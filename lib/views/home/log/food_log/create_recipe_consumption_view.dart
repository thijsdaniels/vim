import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/food/amount.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/food/recipe_consumption.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/consumptions_collection.dart';
import 'package:vim/widgets/atoms/incremental_number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/unit_dropdown_menu.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateRecipeConsumptionView extends StatefulWidget {
  final RecipeConsumption? recipeConsumption;
  final Recipe? recipe;

  const CreateRecipeConsumptionView({
    super.key,
    this.recipeConsumption,
    this.recipe,
  }) : assert(recipe != null || recipeConsumption != null);

  @override
  State<CreateRecipeConsumptionView> createState() =>
      _CreateRecipeConsumptionViewState();
}

class _CreateRecipeConsumptionViewState
    extends State<CreateRecipeConsumptionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _timeController = TextEditingController();

  Timestamp? _timestamp;
  Unit? _unit = Unit.servings;
  num? _amount = 1;

  @override
  void initState() {
    super.initState();

    RecipeConsumption? recipeConsumption = widget.recipeConsumption;

    if (recipeConsumption != null) {
      _timestamp = recipeConsumption.timestamp;
      _unit = recipeConsumption.amount.unit;
      _amount = recipeConsumption.amount.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    Timestamp timestamp = _timestamp ?? DateModel.of(context).timestamp;
    RecipeConsumption? recipeConsumption = widget.recipeConsumption;

    return Scaffold(
      appBar: AppBar(
        title: recipeConsumption != null
            ? Text(recipeConsumption.name)
            : Text(widget.recipe!.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              final navigator = Navigator.of(context);

              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                RecipeConsumption? recipeConsumption = widget.recipeConsumption;

                if (recipeConsumption != null) {
                  recipeConsumption.timestamp = timestamp;
                  recipeConsumption.amount = Amount(
                    unit: _unit!,
                    value: _amount!,
                  );

                  ConsumptionsCollection.of(context).update(recipeConsumption);
                } else {
                  recipeConsumption = await widget.recipe?.consumption(
                    user: User.of(context),
                    timestamp: timestamp,
                    amount: Amount(
                      unit: _unit!,
                      value: _amount!,
                    ),
                  );

                  if (recipeConsumption != null) {
                    ConsumptionsCollection.of(context)
                        .create(recipeConsumption);
                  }
                }

                navigator.pop(recipeConsumption);
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
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: UnitDropdownMenu(
                          value: _unit,
                          onChanged: (unit) {
                            setState(() {
                              _unit = unit;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: IncrementalNumberFormField(
                          decoration: const InputDecoration(
                            labelText: 'Amount',
                            hintText: 'Servings',
                          ),
                          initialValue: _amount,
                          autofocus: true,
                          onChanged: (amount) {
                            setState(() {
                              _amount = amount;
                            });
                          },
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
