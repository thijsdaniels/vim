import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/exercise/resistance_exercise_performance.dart';
import 'package:vim/models/exercise/weights_exercise_performance.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_exercise_performance_view.dart';

class ExercisePerformancesList extends StatelessWidget {
  const ExercisePerformancesList({
    super.key,
    required this.performances,
    this.onChanged,
  });

  final Performances performances;
  final void Function(Performances performances)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      children: performances.asMap().entries.map(
        (entry) {
          ExercisePerformance performance = entry.value as ExercisePerformance;

          return Card(
            // TODO: Use a proper key instead of the index.
            key: Key(entry.key.toString()),
            elevation: 4,
            child: ListTile(
              key: Key(entry.value.name),
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ReorderableDragStartListener(
                    index: entry.key,
                    child: const Icon(Icons.drag_handle),
                  ),
                ],
              ),
              title: Text(performance.exercise.name),
              subtitle: SecondaryText(
                // TODO: Try to change this into Chip widgets.
                [
                  if (performance.exercise.type == ExerciseType.manual)
                    '${performance.calories.round()} cal',
                  if (performance is WeightsExercisePerformance) ...[
                    '${(performance.sets.weight / performance.sets.length)} kg',
                    performance.sets
                        .map(
                          (set) => '${set.repetitions}',
                        )
                        .join("/"),
                  ],
                  if (performance is ResistanceExercisePerformance) ...[
                    '${performance.watts} watts',
                    '${performance.duration.inMinutes} m',
                  ],
                ].join(" • "),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CreateExercisePerformanceView(
                            exercisePerformance: performance,
                          ),
                        ),
                      );

                      onChanged!(performances);
                    },
                  ),
                  WithConfirmationDialog(
                    title: performance.name,
                    description:
                        'Are you sure you want to delete this performance?',
                    builder: (context, confirm) => IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        if (await confirm()) {
                          performances.removeAt(entry.key);
                          onChanged!(performances);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ).toList(),
      onReorder: (oldIndex, newIndex) {
        performances.move(oldIndex, newIndex);
        onChanged!(performances);
      },
    );
  }
}
