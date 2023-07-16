import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_collection.dart';
import 'package:vim/widgets/atoms/multiselect_dropdown.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
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
  ExerciseType? _type;
  MuscleGroup? _primaryMuscleGroup;
  List<MuscleGroup> _secondaryMuscleGroups = [];

  @override
  void initState() {
    super.initState();

    Exercise? exercise = widget.exercise;

    if (exercise != null) {
      _name = exercise.name;
      _type = exercise.type;
      _primaryMuscleGroup = exercise.muscleGroups.primary;
      _secondaryMuscleGroups = exercise.muscleGroups.secondary;
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
                  exercise.type = _type!;
                  exercise.muscleGroups = (
                    primary: _primaryMuscleGroup,
                    secondary: _secondaryMuscleGroups,
                  );

                  ExercisesCollection.of(context).update(exercise);
                } else {
                  ExercisesCollection.of(context).create(Exercise(
                    name: _name!,
                    type: _type!,
                    muscleGroups: (
                      primary: _primaryMuscleGroup,
                      secondary: _secondaryMuscleGroups,
                    ),
                  ));
                }

                Navigator.of(context).pop(exercise);
              }
            },
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: StandardList(
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
                  ExerciseTypeDropdown(
                    value: _type,
                    onChanged: (type) => setState(() {
                      _type = type;
                    }),
                  ),
                ],
              ),
            ),
            SimpleCard(
              title: 'Muscle Groups',
              child: Column(
                children: [
                  MuscleGroupDropdown(
                    value: _primaryMuscleGroup,
                    onChanged: (muscleGroup) => setState(() {
                      _primaryMuscleGroup = muscleGroup;
                    }),
                  ),
                  const SizedBox(height: 16),

                  /// TODO: Improve this UX and get rid of the `multiselect`
                  /// package.
                  MultiselectDropdown<MuscleGroup>(
                    decoration: const InputDecoration(
                      label: Text('Secondary'),
                    ),
                    items: MuscleGroup.values
                        .map((muscleGroup) => (
                              value: muscleGroup,
                              name: muscleGroup.name.toTitleCase(),
                            ))
                        .toList(),
                    selected: _secondaryMuscleGroups,
                    onChanged: (muscleGroups) {
                      setState(() {
                        _secondaryMuscleGroups = muscleGroups;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseTypeDropdown extends StatelessWidget {
  final ExerciseType? value;
  final void Function(ExerciseType? value) onChanged;

  const ExerciseTypeDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ExerciseType>(
      decoration: const InputDecoration(
        label: Text('Type'),
      ),
      value: value,
      items: ExerciseType.values
          .map(
            (type) => DropdownMenuItem<ExerciseType>(
              value: type,
              child: Text(
                type.name.toTitleCase(),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: (value) {
        if (value == null) {
          return 'Please choose a type.';
        }
        return null;
      },
    );
  }
}

class MuscleGroupDropdown extends StatelessWidget {
  final MuscleGroup? value;
  final void Function(MuscleGroup? value) onChanged;

  const MuscleGroupDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<MuscleGroup>(
      decoration: const InputDecoration(
        label: Text('Primary'),
      ),
      value: value,
      items: MuscleGroup.values
          .map(
            (muscleGroup) => DropdownMenuItem<MuscleGroup>(
              value: muscleGroup,
              child: Text(
                muscleGroup.name.toTitleCase(),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
