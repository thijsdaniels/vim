import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
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
    /// TODO: Somehow use the StandardList and make it work with onReorder.
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
      itemCount: exerciseReferences.length,
      itemBuilder: (context, index) {
        var exerciseReference = exerciseReferences[index];
        String id = exerciseReference.id;

        return StreamBuilder<Exercise?>(
          key: Key(index.toString()),
          stream: ExercisesService.instance.get(id),
          builder: (context, snapshot) {
            Exercise? exercise = snapshot.data;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ListSurface(
                elevation: 4,
                title: Text(exercise?.name ?? '...'),
                actions: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WithConfirmationDialog(
                      title: exercise?.name,
                      description:
                          'Are you sure you want to remove this exercise?',
                      builder: (context, confirm) => IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () async {
                          if (await confirm()) {
                            exerciseReferences.remove(exerciseReference);
                            onChanged!(exerciseReferences);
                          }
                        },
                      ),
                    ),
                    ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_handle),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      onReorder: (oldIndex, newIndex) {
        var exercise = exerciseReferences.removeAt(oldIndex);
        exerciseReferences.insert(newIndex, exercise);
        onChanged!(exerciseReferences);
      },
    );
  }
}
