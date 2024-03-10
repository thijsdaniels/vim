import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/exercises_collection_group.dart';
import 'package:vim/services/routines_collection_group.dart';
import 'package:vim/views/home/log/exercise_log/create_exercise_performance_view.dart';
import 'package:vim/views/home/log/exercise_log/create_quick_track_performance_view.dart';
import 'package:vim/widgets/atoms/exercise_icon.dart';
import 'package:vim/widgets/atoms/routine_icon.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/molecules/searchable_list.dart';

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

              await navigator.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const CreateQuickTrackPerformanceView(),
                ),
              );
            },
            icon: const Icon(Icons.flash_on_rounded),
          )
        ],
      ),
      body: StreamBuilder(
        stream: RoutinesCollectionGroup.instance.all(
          users: [user.reference!, ...user.following],
        ),
        builder: (context, routines) => StreamBuilder(
          stream: ExercisesCollectionGroup.instance.all(
            users: [user.reference!, ...user.following],
          ),
          builder: (context, exercises) => SearchableList<NamedDocument>(
            barHintText: "Search",
            items: [
              ...(routines.data ?? []),
              ...(exercises.data ?? []),
            ],
            itemToText: (entry) => entry.searchableText,
            itemBuilder: (context, entry, similarity) => SearchResult(entry),
            noQueryBuilder: (context, entries) => const StandardList(
              children: [
                ListSurface(
                  title: "Dummy Suggestion #1",
                ),
                ListSurface(
                  title: "Dummy Suggestion #2",
                ),
                ListSurface(
                  title: "Dummy Suggestion #3",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchResult extends StatelessWidget {
  final dynamic entry;

  const SearchResult(
    this.entry, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (entry is Routine) {
      return RoutineSearchResult(entry);
    } else if (entry is Exercise) {
      return ExerciseSearchResult(entry);
    } else {
      throw ArgumentError("Invalid entry type.", entry);
    }
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
            navigator.pop(performance);
          }
        },
      ),
    );
  }
}
