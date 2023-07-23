import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/equipments_collection_group.dart';
import 'package:vim/services/exercises_collection.dart';
import 'package:vim/widgets/atoms/multiselect_dropdown.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/slider_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/switch_form_field.dart';
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
  DocumentReference? _equipmentReference;
  num _bodyweightFactor = 0;
  bool _isUnilateral = false;
  MuscleGroup? _primaryMuscleGroup;
  List<MuscleGroup> _secondaryMuscleGroups = [];

  @override
  void initState() {
    super.initState();

    Exercise? exercise = widget.exercise;

    if (exercise != null) {
      _name = exercise.name;
      _type = exercise.type;
      _equipmentReference = exercise.equipmentReference;
      _bodyweightFactor = exercise.bodyweightFactor;
      _isUnilateral = exercise.isUnilateral;
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
                  exercise.equipmentReference = _equipmentReference;
                  exercise.bodyweightFactor = _bodyweightFactor;
                  exercise.isUnilateral = _isUnilateral;
                  exercise.muscleGroups = (
                    primary: _primaryMuscleGroup,
                    secondary: _secondaryMuscleGroups,
                  );

                  ExercisesCollection.of(context).update(exercise);
                } else {
                  ExercisesCollection.of(context).create(Exercise(
                    name: _name!,
                    type: _type!,
                    equipmentReference: _equipmentReference,
                    bodyweightFactor: _bodyweightFactor,
                    isUnilateral: _isUnilateral,
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
              child: StandardList(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
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
                  ExerciseTypeDropdown(
                    value: _type,
                    onChanged: (type) => setState(() {
                      _type = type;
                    }),
                  ),
                ],
              ),
            ),
            if (_type == ExerciseType.weights)
              SimpleCard(
                title: 'Method',
                child: StandardList(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    StreamBuilder(
                      stream: EquipmentsCollectionGroup.instance.all(),
                      builder: (context, equipments) {
                        return DropdownButtonFormField<Equipment>(
                          decoration: const InputDecoration(
                            label: Text('Equipment'),
                          ),
                          items: (equipments.data ?? [])
                              .map((equipment) => DropdownMenuItem<Equipment>(
                                    value: equipment,
                                    child: Text(equipment.name),
                                  ))
                              .toList(),
                          value: (equipments.data ?? [])
                              .where((equipment) =>
                                  equipment.reference?.path ==
                                  _equipmentReference?.path)
                              .firstOrNull,
                          onChanged: (equipment) {
                            setState(() {
                              _equipmentReference = equipment?.reference;
                            });
                          },
                        );
                      },
                    ),
                    SliderFormField(
                      value: _bodyweightFactor.toDouble(),
                      onChanged: (bodyweightFactor) => setState(() {
                        _bodyweightFactor = bodyweightFactor;
                      }),
                      label: const Text('Bodyweight'),
                      divisions: 20,
                      valueLabel:
                          '${(_bodyweightFactor * 100).round().toString()}%',
                    ),
                    SwitchFormField(
                      value: _isUnilateral,
                      onChanged: (isUnilateral) => setState(() {
                        _isUnilateral = isUnilateral;
                      }),
                      label: const Text('Unilateral'),
                    ),
                  ],
                ),
              ),
            SimpleCard(
              title: 'Muscle Groups',
              child: StandardList(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MuscleGroupDropdown(
                    value: _primaryMuscleGroup,
                    onChanged: (muscleGroup) => setState(() {
                      _primaryMuscleGroup = muscleGroup;
                    }),
                  ),
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
              child: Text(switch (type) {
                ExerciseType.manual => 'Manual',
                ExerciseType.resistance => 'Endurance',
                ExerciseType.weights => 'Resistance',
              }),
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
