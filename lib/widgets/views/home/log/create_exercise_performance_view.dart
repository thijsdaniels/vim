import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/sets.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/exercise_dropdown_menu.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateExercisePerformanceView extends StatefulWidget {
  final ExercisePerformance? exercisePerformance;

  const CreateExercisePerformanceView({
    super.key,
    this.exercisePerformance,
  });

  @override
  State<CreateExercisePerformanceView> createState() =>
      _CreateExercisePerformanceViewState();
}

class _CreateExercisePerformanceViewState
    extends State<CreateExercisePerformanceView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Exercise? _exercise;
  num? _calories;
  Sets _sets = Sets([Set()]);
  int? _minutes;
  num? _watts;

  @override
  void initState() {
    super.initState();

    ExercisePerformance? exercisePerformance = widget.exercisePerformance;

    if (exercisePerformance != null) {
      _exercise = exercisePerformance.exercise;
      _calories = exercisePerformance.calories;

      if (exercisePerformance is WeightsExercisePerformance) {
        _sets = exercisePerformance.sets;
      }

      if (exercisePerformance is ResistanceExercisePerformance) {
        _minutes = exercisePerformance.duration.inMinutes;
        _watts = exercisePerformance.watts;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ExercisePerformance? exercisePerformance = widget.exercisePerformance;

    return Scaffold(
      appBar: AppBar(
        title: exercisePerformance == null
            ? const Text('Track Exercise')
            : Text(exercisePerformance.name),
        actions: [
          Consumer<DateModel>(
            builder: (context, dateModel, _) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                FormState formState = _formKey.currentState!;

                if (formState.validate()) {
                  formState.save();

                  ExercisePerformance? exercisePerformance =
                      widget.exercisePerformance;

                  if (exercisePerformance != null) {
                    DocumentReference reference =
                        exercisePerformance.reference!;

                    switch (_exercise!.type) {
                      case ExerciseType.manual:
                        exercisePerformance = ExercisePerformance(
                          timestamp: dateModel.timestamp,
                          exercise: _exercise!,
                          calories: _calories!,
                        );
                        break;
                      case ExerciseType.resistance:
                        exercisePerformance = ResistanceExercisePerformance(
                          timestamp: dateModel.timestamp,
                          exercise: _exercise!,
                          duration: Duration(minutes: _minutes!),
                          watts: _watts!,
                        );
                        break;
                      case ExerciseType.weights:
                        exercisePerformance = WeightsExercisePerformance(
                          timestamp: dateModel.timestamp,
                          exercise: _exercise!,
                          sets: _sets,
                        );
                        break;
                    }

                    reference.set(exercisePerformance.toMap());
                  } else {
                    switch (_exercise!.type) {
                      case ExerciseType.manual:
                        exercisePerformance = ExercisePerformance(
                          timestamp: dateModel.timestamp,
                          exercise: _exercise!,
                          calories: _calories!,
                        );
                        break;
                      case ExerciseType.resistance:
                        exercisePerformance = ResistanceExercisePerformance(
                          timestamp: dateModel.timestamp,
                          exercise: _exercise!,
                          duration: Duration(minutes: _minutes!),
                          watts: _watts!,
                        );
                        break;
                      case ExerciseType.weights:
                        exercisePerformance = WeightsExercisePerformance(
                          timestamp: dateModel.timestamp,
                          exercise: _exercise!,
                          sets: _sets,
                        );
                        break;
                    }

                    PerformancesService.create(exercisePerformance);
                  }

                  Navigator.of(context).pop();
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
              children: [
                if (exercisePerformance == null)
                  SimpleCard(
                    title: 'Details',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ExerciseDropdownMenu(
                          initialSelection: _exercise,
                          onSelected: (Exercise? exercise) {
                            setState(() {
                              _exercise = exercise;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                if (_exercise?.type == ExerciseType.manual)
                  SimpleCard(
                    title: 'Effort',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                if (_exercise?.type == ExerciseType.resistance)
                  SimpleCard(
                    title: 'Effort',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NumberFormField(
                          initialValue: _minutes,
                          onChanged: (minutes) => setState(() {
                            _minutes = minutes?.toInt();
                          }),
                          decoration: const InputDecoration(
                            labelText: 'Duration',
                            hintText: 'Minutes',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a duration.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        NumberFormField(
                          initialValue: _watts,
                          onChanged: (watts) => setState(() {
                            _watts = watts?.toInt();
                          }),
                          decoration: const InputDecoration(
                            labelText: 'Power',
                            hintText: 'Watts',
                          ),
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null) {
                              return 'Please enter a wattage.';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                if (_exercise?.type == ExerciseType.weights)
                  SimpleCard(
                    title: 'Sets',
                    child: SetsFields(
                      sets: _sets,
                      elevation: 4,
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

class SetsFields extends StatefulWidget {
  final Sets sets;
  final double elevation;

  const SetsFields({
    super.key,
    required this.sets,
    this.elevation = 1,
  });

  @override
  State<SetsFields> createState() => _SetsFieldsState();
}

class _SetsFieldsState extends State<SetsFields> {
  @override
  Widget build(BuildContext context) {
    var sets = widget.sets;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ...sets.asMap().entries.map(
          (entry) {
            return Card(
              elevation: widget.elevation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: NumberFormField(
                        initialValue: entry.value.repetitions,
                        onChanged: (repetitions) => setState(() {
                          entry.value.repetitions = repetitions;
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
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: NumberFormField(
                        initialValue: entry.value.weight,
                        onChanged: (weight) => setState(() {
                          entry.value.weight = weight;
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
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: sets.length > 1
                          ? () {
                              setState(() {
                                sets.removeAt(entry.key);
                              });
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: const Text('Add Set'),
            onPressed: () {
              setState(() {
                sets.add(Set(
                  repetitions: sets.last.repetitions,
                  weight: sets.last.weight,
                ));
              });
            },
          ),
        ),
      ],
    );
  }
}
