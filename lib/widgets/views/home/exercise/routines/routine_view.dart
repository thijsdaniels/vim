import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/routines_service.dart';
import 'package:vim/widgets/atoms/muscle_groups.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/exercises_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/exercise/routines/create_routine_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log/select_exercise_view.dart';
import 'package:vim/widgets/views/loading_view.dart';
import 'package:vim/widgets/views/not_found_view.dart';

class RoutineView extends StatelessWidget {
  final String routineId;

  const RoutineView(
    this.routineId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Routine?>(
      stream: RoutinesService.instance.get(routineId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (!snapshot.hasData) {
          return const NotFoundView();
        }

        Routine routine = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            title: Text(routine.name),
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
              WithConfirmationDialog(
                title: routine.name,
                description: 'Are you sure you want to delete this routine?',
                builder: (context, confirm) => IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  onPressed: () async {
                    var navigator = Navigator.of(context);
                    if (await confirm()) {
                      RoutinesService.instance.delete(routine);
                      navigator.pop();
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
                        Text(routine.name),
                      ],
                    ),
                    TableRow(
                      children: [
                        const SecondaryText('Exercises'),
                        const SizedBox(width: 32),
                        Text(
                          routine.exerciseReferences.length.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              /// TODO: Fetch exercises and show muscle groups.
              Row(
                children: [
                  Flexible(
                    child: MuscleGroups(
                      view: MuscleMapView.front,
                      primary: null,
                      secondary: [],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: MuscleGroups(
                      view: MuscleMapView.back,
                      primary: null,
                      secondary: [],
                    ),
                  ),
                ],
              ),
              SimpleCard(
                title: 'Exercises',
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () async {
                      Exercise exercise = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SelectExerciseView(),
                        ),
                      );

                      routine.exerciseReferences.add(exercise.reference!);
                      await RoutinesService.instance.update(routine);
                    },
                  )
                ],
                child: ExercisesList(
                  exerciseReferences: routine.exerciseReferences,
                  onChanged: (exerciseReferences) {
                    routine.exerciseReferences = exerciseReferences;
                    RoutinesService.instance.update(routine);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
