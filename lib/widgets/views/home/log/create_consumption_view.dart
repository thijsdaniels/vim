import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/widgets/molecules/nutrition_form_fields.dart';

class CreateConsumptionView extends StatefulWidget {
  final Consumption? consumption;

  const CreateConsumptionView({super.key, this.consumption});

  @override
  State<CreateConsumptionView> createState() => _CreateConsumptionViewState();
}

class _CreateConsumptionViewState extends State<CreateConsumptionView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Quick Track');
  final NutritionEditingController _nutritionController =
      NutritionEditingController();

  @override
  void initState() {
    super.initState();

    Consumption? consumption = widget.consumption;

    if (consumption != null) {
      _nameController.text = consumption.name;
      _nutritionController.nutrition = consumption.nutrition;
    }
  }

  @override
  Widget build(BuildContext context) {
    Consumption? consumption = widget.consumption;

    return Scaffold(
      appBar: AppBar(
        title: consumption != null
            ? Text(consumption.name)
            : const Text('Quick Track Food'),
        actions: [
          Consumer<DateModel>(
            builder: (context, dateModel, _) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                FormState formState = _formKey.currentState!;

                if (formState.validate()) {
                  formState.save();

                  String name = _nameController.value.text;
                  Nutrition nutrition = _nutritionController.nutrition;

                  Consumption? consumption = widget.consumption;

                  if (consumption != null) {
                    consumption.name = name;
                    consumption.nutrition = nutrition;

                    ConsumptionsService.update(consumption);
                  } else {
                    consumption = Consumption(
                      timestamp: dateModel.timestamp,
                      name: name,
                      nutrition: nutrition,
                    );

                    ConsumptionsService.create(consumption);
                  }

                  Navigator.of(context).pop(consumption);
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name.';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: NutritionFormFields(
                      controller: _nutritionController,
                      autofocus: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
