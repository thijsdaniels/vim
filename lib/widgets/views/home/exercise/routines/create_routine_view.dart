import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/sets.dart';
import 'package:vim/models/exercise/set.dart';
import 'package:vim/services/routines_service.dart';
import 'package:vim/widgets/atoms/exercise_dropdown_menu.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/views/home/log/create_exercise_performance_view.dart';

class CreateRoutineView extends StatefulWidget {
  final Routine? routine;

  const CreateRoutineView({super.key, this.routine});

  @override
  State<CreateRoutineView> createState() => _CreateRoutineViewState();
}

class _CreateRoutineViewState extends State<CreateRoutineView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// TODO: Represent the input with a `RoutineInput _input` and create the
  /// `Routine` using `Routine.fromInput(_input)` or `_input.toRoutine()`, or
  /// just use a `Map<String, dynamic> _input = {'name': '', plan: []}` and
  /// create the routine using `Routine.fromMap(_input)`. The latter of course
  /// isn't as type-safe, so it will be more prone to errors when I change the
  /// `Routine` class in the future. (Dart's upcoming pattern matching feature
  /// should make this more sustainable.)
  String _name = '';
  PlannedPerformances _plan = PlannedPerformances([
    PlannedPerformance(
      sets: Sets([
        Set(repetitions: null, weight: null),
      ]),
    ),
  ]);

  @override
  void initState() {
    super.initState();

    Routine? routine = widget.routine;

    if (routine != null) {
      _name = routine.name;
      _plan = routine.plan;
    }
  }

  @override
  Widget build(BuildContext context) {
    Routine? routine = widget.routine;

    return Scaffold(
      appBar: AppBar(
        title:
            routine != null ? Text(routine.name) : const Text('Create Routine'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                Routine? routine = widget.routine;

                if (routine != null) {
                  routine.name = _name;
                  routine.plan = _plan.trim();

                  RoutinesService.update(routine);
                } else {
                  routine = Routine(
                    name: _name,
                    plan: _plan.trim(),
                  );

                  RoutinesService.create(routine);
                }

                Navigator.of(context).pop(routine);
              }
            },
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
                SimpleCard(
                  title: 'Details',
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: true,
                        initialValue: _name,
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
                        onChanged: (name) {
                          setState(() {
                            _name = name;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SimpleCard(
                  title: 'Exercises',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ..._plan.asMap().entries.map(
                        (entry) {
                          return Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: FutureBuilder(
                                future: entry.value.exercise,
                                builder: (context, snapshot) {
                                  // if (!snapshot.hasData) {
                                  //   return const CircularProgressIndicator();
                                  // }

                                  Exercise? exercise = snapshot.data;

                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ExerciseDropdownMenu(
                                              initialSelection: exercise,
                                              onSelected: (exercise) {
                                                setState(() {
                                                  entry.value
                                                          .exerciseReference =
                                                      exercise?.reference;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          IconButton(
                                            icon: const Icon(Icons.clear),
                                            onPressed: _plan.length > 1
                                                ? () {
                                                    setState(() {
                                                      _plan.removeAt(entry.key);
                                                    });
                                                  }
                                                : null,
                                          ),
                                        ],
                                      ),
                                      if (exercise?.type == ExerciseType.manual)
                                        Column(
                                          children: [
                                            const SizedBox(height: 16),
                                            NumberFormField(
                                              initialValue:
                                                  entry.value.calories,
                                              decoration: const InputDecoration(
                                                labelText: 'Calories',
                                              ),
                                              textInputAction:
                                                  TextInputAction.done,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Please enter an amount.';
                                                }
                                                return null;
                                              },
                                              onChanged: (calories) {
                                                setState(() {
                                                  entry.value.calories =
                                                      calories;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      if (exercise?.type ==
                                          ExerciseType.resistance)
                                        Column(
                                          children: [
                                            const SizedBox(height: 16),
                                            NumberFormField(
                                              initialValue: entry.value.minutes,
                                              decoration: const InputDecoration(
                                                labelText: 'Duration',
                                                hintText: 'Minutes',
                                              ),
                                              textInputAction:
                                                  TextInputAction.done,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Please enter an amount.';
                                                }
                                                return null;
                                              },
                                              onChanged: (minutes) {
                                                setState(() {
                                                  entry.value.minutes =
                                                      minutes?.toInt();
                                                });
                                              },
                                            ),
                                            const SizedBox(height: 16),
                                            NumberFormField(
                                              initialValue: entry.value.watts,
                                              decoration: const InputDecoration(
                                                labelText: 'Power',
                                                hintText: 'Watts',
                                              ),
                                              textInputAction:
                                                  TextInputAction.done,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Please enter an amount.';
                                                }
                                                return null;
                                              },
                                              onChanged: (watts) {
                                                setState(() {
                                                  entry.value.watts = watts;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      if (exercise?.type ==
                                          ExerciseType.weights)
                                        Column(
                                          children: [
                                            const SizedBox(height: 16),
                                            SetsFields(
                                              sets: entry.value.sets!,
                                              elevation: 8,
                                            ),
                                          ],
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                          child: const Text('Add Exercise'),
                          onPressed: () {
                            setState(() {
                              _plan.add(PlannedPerformance(
                                sets: Sets([
                                  Set(repetitions: null, weight: null),
                                ]),
                              ));
                            });
                          },
                        ),
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
