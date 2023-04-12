import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_service.dart';
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

  @override
  void initState() {
    super.initState();

    Exercise? exercise = widget.exercise;

    if (exercise != null) {
      _name = exercise.name;
      _type = exercise.type;
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

                  ExercisesService.instance.update(exercise);
                } else {
                  ExercisesService.instance.create(Exercise(
                    name: _name!,
                    type: _type!,
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
                  DropdownButtonFormField<ExerciseType>(
                    decoration: const InputDecoration(
                      label: Text('Type'),
                    ),
                    value: _type,
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
                    onChanged: (type) => setState(() {
                      _type = type;
                    }),
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose a type.';
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
    );
  }
}
