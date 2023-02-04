import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/atoms/exercise_dropdown_menu.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class CreateExercisePerformanceView extends StatefulWidget {
  const CreateExercisePerformanceView({super.key});

  @override
  State<CreateExercisePerformanceView> createState() =>
      _CreateExercisePerformanceViewState();
}

class _CreateExercisePerformanceViewState
    extends State<CreateExercisePerformanceView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Exercise? _exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Exercise'),
        actions: [
          Consumer<DateModel>(
            builder: (context, dateModel, _) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                FormState formState = _formKey.currentState!;

                if (formState.validate()) {
                  formState.save();

                  PerformancesService.create(
                    _exercise!.performance(
                      timestamp: dateModel.timestamp,
                    ),
                  );

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
            child: SimpleCard(
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
          ),
        ),
      ),
    );
  }
}
