import 'package:flutter/material.dart';
import 'package:vim/models/exercise/weights_exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateWeightsExerciseView extends StatefulWidget {
  final WeightsExercise? exercise;

  const CreateWeightsExerciseView({super.key, this.exercise});

  @override
  State<CreateWeightsExerciseView> createState() =>
      _CreateWeightsExerciseViewState();
}

class _CreateWeightsExerciseViewState extends State<CreateWeightsExerciseView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  num? _calories;
  num? _sets;
  num? _repetitions;
  num? _weight;

  @override
  void initState() {
    super.initState();

    WeightsExercise? exercise = widget.exercise;

    if (exercise != null) {
      _name = exercise.name;
      _calories = exercise.calories;
      _sets = exercise.sets;
      _repetitions = exercise.repetitions;
      _weight = exercise.weight;
    }
  }

  @override
  Widget build(BuildContext context) {
    WeightsExercise? exercise = widget.exercise;

    return Scaffold(
      appBar: AppBar(
        title: exercise != null
            ? Text(exercise.name)
            : const Text('Create Weights Exercise'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                WeightsExercise? exercise = widget.exercise;

                if (exercise != null) {
                  exercise.name = _name!;
                  exercise.calories = _calories!;
                  exercise.sets = _sets!;
                  exercise.repetitions = _repetitions!;
                  exercise.weight = _weight!;

                  ExercisesService.update(exercise);
                } else {
                  exercise = WeightsExercise(
                    name: _name!,
                    calories: _calories!,
                    sets: _sets!,
                    repetitions: _repetitions!,
                    weight: _weight!,
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
                      const SizedBox(height: 16),
                      NumberFormField(
                        initialValue: _calories,
                        onChanged: (calories) => setState(() {
                          _calories = calories;
                        }),
                        decoration: const InputDecoration(
                          labelText: 'Calories',
                        ),
                        textInputAction: TextInputAction.next,
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
                SimpleCard(
                  title: 'Effort',
                  child: Column(
                    children: [
                      NumberFormField(
                        initialValue: _sets,
                        onChanged: (sets) => setState(() {
                          _sets = sets;
                        }),
                        decoration: const InputDecoration(
                          labelText: 'Sets',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter an amount.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      NumberFormField(
                        initialValue: _repetitions,
                        onChanged: (repetitions) => setState(() {
                          _repetitions = repetitions;
                        }),
                        decoration: const InputDecoration(
                          labelText: 'Repetitions',
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null) {
                            return 'Please enter an amount.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      NumberFormField(
                        initialValue: _weight,
                        onChanged: (weight) => setState(() {
                          _weight = weight;
                        }),
                        decoration: const InputDecoration(
                          labelText: 'Weight',
                          hintText: 'Kilograms',
                        ),
                        textInputAction: TextInputAction.next,
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
