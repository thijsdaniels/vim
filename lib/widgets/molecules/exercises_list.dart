import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';

class ExercisesList extends StatelessWidget {
  const ExercisesList({
    super.key,
    required this.exerciseReferences,
    this.onChanged,
  });

  final List<DocumentReference> exerciseReferences;
  final void Function(List<DocumentReference> exercises)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      children: exerciseReferences.asMap().entries.map(
        (entry) {
          String id = entry.value.id;

          return StreamBuilder<Exercise?>(
            key: Key(id),
            stream: ExercisesService.instance.get(id),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text('loading...');
              }

              Exercise exercise = snapshot.data!;

              return Card(
                elevation: 4,
                child: ListTile(
                  key: Key(exercise.name),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ReorderableDragStartListener(
                        index: entry.key,
                        child: const Icon(Icons.drag_handle),
                      ),
                    ],
                  ),
                  title: Text(exercise.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      WithConfirmationDialog(
                        title: exercise.name,
                        description:
                            'Are you sure you want to remove this exercise?',
                        builder: (context, confirm) => IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () async {
                            if (await confirm()) {
                              exerciseReferences.remove(entry.value);
                              onChanged!(exerciseReferences);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ).toList(),
      onReorder: (oldIndex, newIndex) {
        var exercise = exerciseReferences.removeAt(oldIndex);
        exerciseReferences.insert(newIndex, exercise);
        onChanged!(exerciseReferences);
      },
    );
  }
}
