import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/performances_collection_group.dart';
import 'package:vim/services/routines_collection.dart';
import 'package:vim/services/routines_collection_group.dart';
import 'package:vim/views/routines/create_routine_view.dart';
import 'package:vim/views/log/exercise_log/select_exercise_view.dart';
import 'package:vim/views/loading_view.dart';
import 'package:vim/views/not_found_view.dart';
import 'package:vim/widgets/atoms/routine_muscle_groups.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/performances_list.dart';
import 'package:vim/widgets/molecules/routine_exercises_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';

class RoutineView extends StatelessWidget {
  final String path;

  const RoutineView({
    super.key,
    required this.path,
  });

  bool isOwner(Routine routine, User user) {
    return routine.reference!.parent.parent!.id == user.reference!.id;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Routine?>(
      stream: RoutinesCollectionGroup.instance.get(path),
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
              if (isOwner(routine, User.of(context))) ...[
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
                        RoutinesCollection.of(context).delete(routine);
                        navigator.pop();
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
          body: StandardList(
            children: [
              SimpleCard(
                title: 'Details',
                child: StatsTable(
                  children: [
                    StatsRow('Name', routine.name),
                    StatsRow(
                      'Exercises',
                      routine.exerciseReferences.length.toString(),
                    ),
                  ],
                ),
              ),
              RoutineMuscleGroups(
                routine: routine,
              ),
              SimpleCard(
                title: 'Exercises',
                actions: [
                  if (isOwner(routine, User.of(context)))
                    IconButton(
                      icon: const Icon(Icons.add),

                      /// TODO: Instead of going to a new view to render a
                      /// `SearchAnchor` widget, which again renders its own view
                      /// to show search results, I should just open the
                      /// `SearchAnchor` directly from here.
                      onPressed: () async {
                        Exercise? exercise = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SelectExerciseView(),
                          ),
                        );

                        if (exercise != null) {
                          routine.exerciseReferences.add(exercise.reference!);
                          await RoutinesCollection.of(context).update(routine);
                        }
                      },
                    )
                ],
                child: RoutineExercisesList(
                  exerciseReferences: routine.exerciseReferences,
                  onChanged: isOwner(routine, User.of(context))
                      ? (exerciseReferences) {
                          routine.exerciseReferences = exerciseReferences;
                          RoutinesCollection.of(context).update(routine);
                        }
                      : null,
                ),
              ),
              StreamBuilder(
                stream: PerformancesCollectionGroup.instance.forRoutine(
                  routine,
                  user: User.of(context),
                ),
                builder: (context, snapshot) => SimpleCard(
                  title: "History",
                  child: PerformancesList(
                    performances: snapshot.data ?? [],
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    elevation: 4,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
