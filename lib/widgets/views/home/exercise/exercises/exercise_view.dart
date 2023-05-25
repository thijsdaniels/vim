import 'package:flutter/material.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/exercise/exercises/create_exercise_view.dart';
import 'package:vim/widgets/views/loading_view.dart';
import 'package:vim/widgets/views/not_found_view.dart';

class ExerciseView extends StatelessWidget {
  final String exerciseId;

  const ExerciseView(
    this.exerciseId, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Exercise?>(
        stream: ExercisesService.instance.get(exerciseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView();
          }

          if (!snapshot.hasData) {
            return const NotFoundView();
          }

          Exercise exercise = snapshot.requireData!;

          return Scaffold(
            appBar: AppBar(
              title: Text(exercise.name),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateExerciseView(
                          exercise: exercise,
                        ),
                      ),
                    );
                  },
                ),
                WithConfirmationDialog(
                  title: exercise.name,
                  description: 'Are you sure you want to delete this exercise?',
                  builder: (context, confirm) => IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () async {
                      var navigator = Navigator.of(context);
                      if (await confirm()) {
                        ExercisesService.instance.delete(exercise);
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
                          Text(exercise.name),
                        ],
                      ),
                      TableRow(
                        children: [
                          const SecondaryText('Type'),
                          const SizedBox(width: 32),
                          Text(exercise.type.name.toTitleCase()),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
