import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateExerciseView extends StatefulWidget {
  final Exercise? exercise;

  const CreateExerciseView({super.key, this.exercise});

  @override
  State<CreateExerciseView> createState() => _CreateExerciseViewState();
}

class _CreateExerciseViewState extends State<CreateExerciseView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  num? _calories;

  @override
  void initState() {
    super.initState();

    Exercise? exercise = widget.exercise;

    if (exercise != null) {
      _name = exercise.name;
      _calories = exercise.calories;
    }
  }

  @override
  Widget build(BuildContext context) {
    Exercise? exercise = widget.exercise;

    return Scaffold(
      appBar: AppBar(
        title: exercise != null
            ? Text(exercise.name)
            : const Text('Create Exercise'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                Exercise? exercise = widget.exercise;

                if (exercise != null) {
                  exercise.name = _name!;
                  exercise.calories = _calories!;

                  ExercisesService.update(exercise);
                } else {
                  exercise = Exercise(
                    name: _name!,
                    calories: _calories!,
                  );

                  ExercisesService.create(exercise);
                }

                Navigator.of(context).pop(exercise);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SimpleCard(
                  title: 'Details',
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        initialValue: _name,
                        onChanged: (name) => setState(() {
                          _name = name;
                        }),
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
                    ],
                  ),
                ),
                SimpleCard(
                  title: 'Effort',
                  child: Column(
                    children: [
                      NumberFormField(
                        initialValue: _calories,
                        onChanged: (calories) => setState(() {
                          _calories = calories;
                        }),
                        decoration: const InputDecoration(
                          labelText: 'Calories',
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
        ),
      ),
    );
  }
}
