import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/performance.dart';
import 'package:vim/services/performances_service.dart';

class CreatePerformanceView extends StatefulWidget {
  final Performance? performance;

  const CreatePerformanceView({super.key, this.performance});

  @override
  State<CreatePerformanceView> createState() => _CreatePerformanceViewState();
}

class _CreatePerformanceViewState extends State<CreatePerformanceView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController =
      TextEditingController(text: 'Quick Track');
  final TextEditingController _caloriesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.performance != null) {
      _nameController.text = widget.performance!.name;
      _caloriesController.text = widget.performance!.calories.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Performance? performance = widget.performance;

    return Scaffold(
      appBar: AppBar(
        title: performance != null
            ? Text(performance.name)
            : const Text('Quick Track Exercise'),
        actions: [
          Consumer<DateModel>(
            builder: (context, dateModel, child) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                FormState formState = _formKey.currentState!;

                if (formState.validate()) {
                  formState.save();

                  String name = _nameController.value.text;
                  int calories = int.parse(_caloriesController.value.text);

                  Performance? performance = widget.performance;

                  if (performance != null) {
                    performance.name = name;
                    performance.calories = calories;

                    PerformancesService.update(performance);
                  } else {
                    performance = Performance(
                      timestamp: dateModel.timestamp,
                      name: name,
                      calories: calories,
                    );

                    PerformancesService.create(performance);
                  }

                  Navigator.of(context).pop(performance);
                }
              },
            ),
          )
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
                  children: <Widget>[
                    TextFormField(
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
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _caloriesController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Calories',
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a number.';
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
      ),
    );
  }
}
