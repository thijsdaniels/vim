import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/sets.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/widgets/atoms/exercise_dropdown_menu.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/sets_form_field.dart';
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
  List<Map<String, dynamic>> _sets = [{}];
  int? _minutes;
  num? _watts;

  @override
  void initState() {
    super.initState();

    ExercisePerformance? exercisePerformance = widget.exercisePerformance;

    if (exercisePerformance != null) {
      _exercise = exercisePerformance.exercise;
      _calories = 0; // exercisePerformance.calories; // TODO: Fix this

      if (exercisePerformance is WeightsExercisePerformance) {
        _sets = exercisePerformance.sets.toMap();
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
            ? const Text('Perform Exercise')
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
                    if (exercisePerformance is ResistanceExercisePerformance) {
                      exercisePerformance.timestamp = dateModel.timestamp;
                      exercisePerformance.exercise = _exercise!;
                      exercisePerformance.duration =
                          Duration(minutes: _minutes!);
                      exercisePerformance.watts = _watts!;
                    } else if (exercisePerformance
                        is WeightsExercisePerformance) {
                      exercisePerformance.timestamp = dateModel.timestamp;
                      exercisePerformance.exercise = _exercise!;
                      exercisePerformance.sets = Sets.fromMap(_sets);
                    } else {
                      exercisePerformance.timestamp = dateModel.timestamp;
                      exercisePerformance.exercise = _exercise!;
                      exercisePerformance.setCalories(_calories!);
                    }
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
                          sets: Sets.fromMap(_sets),
                        );
                        break;
                    }
                  }

                  Navigator.of(context).pop(exercisePerformance);
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
                    child: SetsFormFields(
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
