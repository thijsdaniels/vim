import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_collection_group.dart';
import 'package:vim/widgets/atoms/exercise_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class SelectExerciseView extends StatefulWidget {
  final Exercise? exercise;

  const SelectExerciseView({
    super.key,
    this.exercise,
  });

  @override
  State<SelectExerciseView> createState() => _SelectExerciseViewState();
}

class _SelectExerciseViewState extends State<SelectExerciseView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Exercise? _exercise;

  @override
  Widget build(BuildContext context) {
    Exercise? exercise = widget.exercise;

    return Scaffold(
      appBar: AppBar(
        title: exercise == null
            ? const Text('Select Exercise')
            : Text(exercise.name),
        actions: [
          Consumer<DateModel>(
            builder: (context, dateModel, _) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                FormState formState = _formKey.currentState!;

                if (formState.validate()) {
                  formState.save();

                  Exercise? exercise = widget.exercise;

                  if (exercise != null) {
                    // no-op
                  } else {
                    exercise = _exercise;
                  }

                  Navigator.of(context).pop(exercise);
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
                if (exercise == null)
                  SimpleCard(
                    title: 'Details',
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreamBuilder(
                          stream: ExercisesCollectionGroup.instance.all(),

                          /// TODO: Figure out a way to get rid of the
                          /// `CircularProgressIndicator`. Doing so currently causes
                          /// an assertion error.
                          builder: (context, exercises) => exercises.hasData
                              ? ExerciseFormField(
                                  exercises: exercises.data!,
                                  selection: _exercise,
                                  onSelected: (exercise) {
                                    setState(() {
                                      _exercise = exercise;
                                    });
                                  },
                                )
                              : const CircularProgressIndicator(),
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
