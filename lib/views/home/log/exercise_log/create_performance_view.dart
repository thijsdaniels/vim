import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/exercises_collection_group.dart';
import 'package:vim/services/routines_collection_group.dart';
import 'package:vim/widgets/atoms/exercise_icon.dart';
import 'package:vim/widgets/atoms/routine_icon.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/views/home/log/exercise_log/create_exercise_performance_view.dart';
import 'package:vim/views/home/log/exercise_log/create_quick_track_performance_view.dart';

class CreatePerformanceView extends StatefulWidget {
  const CreatePerformanceView({super.key});

  @override
  State<CreatePerformanceView> createState() => _CreatePerformanceViewState();
}

class _CreatePerformanceViewState extends State<CreatePerformanceView> {
  @override
  Widget build(BuildContext context) {
    var user = User.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Performance"),
        actions: [
          IconButton(
            onPressed: () async {
              var navigator = Navigator.of(context);

              Performance? performance = await navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const CreateQuickTrackPerformanceView(),
                ),
              );

              if (performance != null) {
                navigator.pop(performance);
              }
            },
            icon: const Icon(Icons.flash_on_rounded),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: RoutinesCollectionGroup.instance.all(
            users: [user.reference!, ...user.following],
          ),
          builder: (context, routines) => StreamBuilder(
            stream: ExercisesCollectionGroup.instance.all(
              users: [user.reference!, ...user.following],
            ),
            builder: (context, exercises) => SearchAnchor.bar(
              viewElevation: 1,
              isFullScreen: true,
              barHintText: "Search",
              suggestionsBuilder: (context, controller) {
                return [
                  const SizedBox(height: 6),
                  ...(routines.data ?? [])
                      .where((recipe) => isMatch(recipe.name, controller))
                      .map(
                        (recipe) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: RoutineSearchResult(recipe),
                        ),
                      ),
                  ...(exercises.data ?? [])
                      .where(
                        (ingredient) => isMatch(ingredient.name, controller),
                      )
                      .map(
                        (ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: ExerciseSearchResult(ingredient),
                        ),
                      ),
                  const SizedBox(height: 6),
                ];
              },
            ),
          ),
        ),
      ),
    );
  }

  bool isMatch(String text, SearchController controller) {
    return text.toLowerCase().contains(controller.value.text.toLowerCase());
  }
}

class RoutineSearchResult extends StatelessWidget {
  final Routine routine;

  const RoutineSearchResult(
    this.routine, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, _) => ListSurface(
        elevation: 4,
        icon: RoutineIcon(routine: routine),
        title: routine.name,
        subtitle: 'Routine',
        onTap: () {
          var navigator = Navigator.of(context);
          navigator.pop();
          navigator.pop(
            routine.performance(
              user: user,
              timestamp: DateModel.of(context).timestamp,
            ),
          );
        },
      ),
    );
  }
}

class ExerciseSearchResult extends StatelessWidget {
  final Exercise exercise;

  const ExerciseSearchResult(
    this.exercise, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: exercise.equipment,
      builder: (context, equipment) => ListSurface(
        elevation: 4,
        icon: ExerciseIcon(exercise, elevation: 8),
        title: exercise.name,
        subtitle: equipment.data?.name,
        onTap: () async {
          var navigator = Navigator.of(context);

          ExercisePerformance? performance = await navigator.push(
            MaterialPageRoute(
              builder: (context) => CreateExercisePerformanceView(
                exercise: exercise,
              ),
            ),
          );

          if (performance != null) {
            navigator.pop();
            navigator.pop(performance);
          }
        },
      ),
    );
  }
}
