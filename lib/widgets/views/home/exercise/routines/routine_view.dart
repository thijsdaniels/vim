import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/routines_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/exercises_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/exercise/routines/create_routine_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log/select_exercise_view.dart';

class RoutineView extends StatefulWidget {
  final String routineId;

  const RoutineView(
    this.routineId, {
    super.key,
  });

  @override
  State<RoutineView> createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Routine?>(
      stream: RoutinesService.get(widget.routineId),
      builder: (context, snapshot) {
        Routine? routine = snapshot.data;

        return Scaffold(
          appBar: AppBar(
            title: Text(routine?.name ?? '...'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreateRoutineView(
                        routine: routine,
                      ),
                    ),
                  );
                },
              ),
              if (routine != null)
                WithConfirmationDialog(
                  title: routine.name,
                  description: 'Are you sure you want to delete this routine?',
                  builder: (context, confirm) => IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () async {
                      if (await confirm()) {
                        RoutinesService.delete(routine);

                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                ),
            ],
          ),
          body: StandardList(
            children: [
              SimpleCard(
                title: 'Details',
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  children: [
                    TableRow(
                      children: [
                        const SecondaryText('Name'),
                        const SizedBox(width: 32),
                        if (routine != null) Text(routine.name),
                      ],
                    ),
                    TableRow(
                      children: [
                        const SecondaryText('Exercises'),
                        const SizedBox(width: 32),
                        if (routine != null)
                          Text(
                            routine.exerciseReferences.length.toString(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              SimpleCard(
                title: 'Exercises',
                actions: [
                  if (routine != null)
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        Exercise exercise = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SelectExerciseView(),
                          ),
                        );

                        routine.exerciseReferences.add(exercise.reference!);
                        await RoutinesService.update(routine);
                      },
                    )
                ],
                child: routine != null
                    ? ExercisesList(
                        exerciseReferences: routine.exerciseReferences,
                        onChanged: (exerciseReferences) {
                          routine.exerciseReferences = exerciseReferences;
                          RoutinesService.update(routine);
                        },
                      )
                    : const CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }
}
