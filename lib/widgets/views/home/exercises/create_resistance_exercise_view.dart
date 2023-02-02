import 'package:flutter/material.dart';
import 'package:vim/models/exercise/resistance_exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateResistanceExerciseView extends StatefulWidget {
  final ResistanceExercise? exercise;

  const CreateResistanceExerciseView({super.key, this.exercise});

  @override
  State<CreateResistanceExerciseView> createState() =>
      _CreateResistanceExerciseViewState();
}

class _CreateResistanceExerciseViewState
    extends State<CreateResistanceExerciseView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _name;
  int? _minutes;
  num? _watts;

  @override
  void initState() {
    super.initState();

    ResistanceExercise? exercise = widget.exercise;

    if (exercise != null) {
      _name = exercise.name;
      _minutes = exercise.duration.inMinutes;
      _watts = exercise.watts;
    }
  }

  @override
  Widget build(BuildContext context) {
    ResistanceExercise? exercise = widget.exercise;

    return Scaffold(
      appBar: AppBar(
        title: exercise != null
            ? Text(exercise.name)
            : const Text('Create Resistance Exercise'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              FormState formState = _formKey.currentState!;

              if (formState.validate()) {
                formState.save();

                ResistanceExercise? exercise = widget.exercise;

                if (exercise != null) {
                  exercise.name = _name!;
                  exercise.duration = Duration(minutes: _minutes!);
                  exercise.watts = _watts!;

                  ExercisesService.update(exercise);
                } else {
                  exercise = ResistanceExercise(
                    name: _name!,
                    duration: Duration(minutes: _minutes!),
                    watts: _watts!,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
