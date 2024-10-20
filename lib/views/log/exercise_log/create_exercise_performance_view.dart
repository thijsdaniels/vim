import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/sets.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/endurance_exercise_performance.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/manual_exercise_performance.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/performances_collection_group.dart';
import 'package:vim/widgets/atoms/incremental_number_form_field.dart';
import 'package:vim/widgets/atoms/sets_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateExercisePerformanceView extends StatefulWidget {
  final ExercisePerformance? exercisePerformance;
  final Exercise? exercise;

  const CreateExercisePerformanceView({
    super.key,
    this.exercisePerformance,
    this.exercise,
  }) : assert(exercise != null || exercisePerformance != null);

  @override
  State<CreateExercisePerformanceView> createState() =>
      _CreateExercisePerformanceViewState();
}

class _CreateExercisePerformanceViewState
    extends State<CreateExercisePerformanceView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  num? _calories;
  List<SetRecord>? _sets;
  int? _minutes;
  num? _watts;

  @override
  void initState() {
    super.initState();

    ExercisePerformance? exercisePerformance = widget.exercisePerformance;

    if (exercisePerformance is ManualExercisePerformance) {
      _calories = exercisePerformance.calories;
    } else if (exercisePerformance is ResistanceExercisePerformance) {
      _sets = exercisePerformance.sets
          .map((set) => (
                key: UniqueKey(),
                repetitions: set.repetitions,
                weight: set.weight
              ))
          .toList();
    } else if (exercisePerformance is EnduranceExercisePerformance) {
      _minutes = exercisePerformance.duration.inMinutes;
      _watts = exercisePerformance.watts;
    }
  }

  @override
  Widget build(BuildContext context) {
    ExercisePerformance? exercisePerformance = widget.exercisePerformance;

    return Consumer<User>(
      builder: (context, user, _) => Consumer<DateModel>(
        builder: (context, dateModel, _) => StreamBuilder(
            stream: widget.exercise != null
                ? PerformancesCollectionGroup.instance.forExercise(
                    widget.exercise!,
                    user: user,
                    limit: 1,
                    before: dateModel.timestamp,
                  )
                : null,
            builder: (context, latestPerformances) {
              if (widget.exercise != null && !latestPerformances.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              var latestPerformance = latestPerformances.data?.firstOrNull;

              var calories = _calories ??
                  (latestPerformance is ManualExercisePerformance
                      ? latestPerformance.calories
                      : null);

              var minutes = _minutes ??
                  (latestPerformance is EnduranceExercisePerformance
                      ? latestPerformance.duration.inMinutes
                      : null);

              var watts = _watts ??
                  (latestPerformance is EnduranceExercisePerformance
                      ? latestPerformance.watts
                      : null);

              var sets = _sets ??
                  (latestPerformance is ResistanceExercisePerformance
                      ? latestPerformance.sets
                          .map((set) => (
                                key: UniqueKey(),
                                weight: set.weight,
                                repetitions: set.repetitions,
                              ))
                          .toList()
                      : [(key: UniqueKey(), weight: null, repetitions: 10)]);

              return Scaffold(
                appBar: AppBar(
                  title: exercisePerformance == null
                      ? Text(widget.exercise!.name)
                      : Text(exercisePerformance.name),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {
                        FormState formState = _formKey.currentState!;

                        if (formState.validate()) {
                          formState.save();

                          ExercisePerformance? exercisePerformance =
                              widget.exercisePerformance;

                          if (exercisePerformance != null) {
                            if (exercisePerformance
                                is EnduranceExercisePerformance) {
                              exercisePerformance.duration =
                                  Duration(minutes: minutes!);
                              exercisePerformance.watts = watts!;
                            } else if (exercisePerformance
                                is ResistanceExercisePerformance) {
                              exercisePerformance.sets = Sets.fromRecords(sets);
                            } else if (exercisePerformance
                                is ManualExercisePerformance) {
                              exercisePerformance.calories = calories!;
                            }
                          } else {
                            switch (widget.exercise!.type) {
                              case ExerciseType.manual:
                                exercisePerformance = ManualExercisePerformance(
                                  user: user.reference!,
                                  timestamp: dateModel.timestamp,
                                  exercise: widget.exercise!.toSnapshot(),
                                  calories: calories!,
                                );
                                break;
                              case ExerciseType.resistance:
                                exercisePerformance =
                                    EnduranceExercisePerformance(
                                  user: user.reference!,
                                  timestamp: dateModel.timestamp,
                                  exercise: widget.exercise!.toSnapshot(),
                                  duration: Duration(minutes: minutes!),
                                  watts: watts!,
                                );
                                break;
                              case ExerciseType.weights:
                                exercisePerformance =
                                    ResistanceExercisePerformance(
                                  user: user.reference!,
                                  timestamp: dateModel.timestamp,
                                  exercise: widget.exercise!.toSnapshot(),
                                  bodyweight: user.body.weight,
                                  sets: Sets.fromRecords(sets),
                                );
                                break;
                            }
                          }

                          Navigator.of(context).pop(exercisePerformance);
                        }
                      },
                    ),
                  ],
                ),
                body: Form(
                  key: _formKey,
                  child: StandardList(
                    children: [
                      if (exerciseType == ExerciseType.manual)
                        SimpleCard(
                          title: 'Effort',
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IncrementalNumberFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Calories',
                                ),
                                initialValue: calories,
                                onChanged: (calories) => setState(() {
                                  _calories = calories;
                                }),
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
                      if (exerciseType == ExerciseType.resistance)
                        SimpleCard(
                          title: 'Effort',
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IncrementalNumberFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Duration',
                                  hintText: 'Minutes',
                                ),
                                initialValue: minutes,
                                onChanged: (minutes) => setState(() {
                                  _minutes = minutes?.toInt();
                                }),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please enter a duration.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),
                              IncrementalNumberFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Power',
                                  hintText: 'Watts',
                                ),
                                initialValue: watts,
                                onChanged: (watts) => setState(() {
                                  _watts = watts?.toInt();
                                }),
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
                      if (exerciseType == ExerciseType.weights)
                        SetsFormFields(
                          exercise: (widget.exercise ??
                              widget.exercisePerformance?.exercise.snapshot)!,
                          sets: sets,
                          onChanged: (sets) => setState(() {
                            _sets = sets;
                          }),
                        ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  ExerciseType get exerciseType {
    return (widget.exercise?.type ??
        widget.exercisePerformance?.exercise.snapshot.type)!;
  }
}
