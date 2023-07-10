import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise_performance.dart';
import 'package:vim/models/exercise/routine_performance.dart';
import 'package:vim/models/food/ingredient_amount_reference.dart';
import 'package:vim/models/food/ingredient_amounts_reference.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/services/routines_service.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';

class DebugView extends StatelessWidget {
  const DebugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: const Center(child: MigrateButton()),
    );
  }
}

class MigrateButton extends StatelessWidget {
  const MigrateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return WithConfirmationDialog(
      builder: (context, confirm) => FilledButton(
        onPressed: () async {
          if (!(await confirm())) {
            return;
          }
        },
        child: const Text('Migrate'),
      ),
    );
  }

  Future<void> traverse<D>(
    CollectionReference<D> collection,
    Future<void> Function(D document, int index, int length) visit,
  ) async {
    var snapshots = (await collection.get()).docs;
    var documents = snapshots.map((doc) => doc.data()).toList();

    for (var i = 0; i < documents.length; i++) {
      await visit(documents[i], i, documents.length);
    }
  }

  /// TODO: Add proper support to move an ingredient from the public scope to
  /// the private scope and vice versa. The official implementation should not
  /// traverse through _all_ recipes (and consumptions), but specifically update
  /// only those documents that contain references to the moved ingredient.
  Future<void> moveIngredients(BuildContext context) async {
    var ingredients = ExercisesService(null).collection;
    var myIngredients = ExercisesService.of(context).collection;
    var myRecipes = RecipesService.of(context).collection;

    print('copying ingredients...');
    await traverse(ingredients, (ingredient, index, length) async {
      print('  copying ingredient ${index + 1} of $length...');
      await myIngredients.doc(ingredient.reference!.id).set(ingredient);
      print('  done.');
    });
    print('done.');

    print('traversing myRecipes...');
    await traverse(
      myRecipes,
      (recipe, index, length) async {
        print('  updating recipe ${index + 1} of $length...');
        recipe.ingredientAmounts = IngredientAmountsReference(
          recipe.ingredientAmounts
              .map(
                (ingredientAmount) => IngredientAmountReference(
                  ingredientReference: myIngredients
                      .doc(ingredientAmount.ingredientReference.id),
                  amount: ingredientAmount.amount,
                ),
              )
              .toList(),
        );

        myRecipes.doc(recipe.reference!.id).set(recipe);
        print('  done.');
      },
    );
    print('done.');
  }

  /// TODO: Add proper support to move an exercise from the public scope to
  /// the private scope and vice versa. The official implementation should not
  /// traverse through _all_ routines and performances, but specifically update
  /// only those documents that contain references to the moved exercise.
  Future<void> moveExercises(BuildContext context) async {
    var exercises = ExercisesService(null).collection;
    var myExercises = ExercisesService.of(context).collection;
    var myRoutines = RoutinesService.of(context).collection;
    var myPerformances = PerformancesService.of(context).collection;

    print('copying exercises...');
    await traverse(exercises, (exercise, index, length) async {
      print('  copying exercise ${index + 1} of $length...');
      await myExercises.doc(exercise.reference!.id).set(exercise);
      print('  done.');
    });
    print('done.');

    print('traversing myRoutines...');
    await traverse(
      myRoutines,
      (routine, index, length) async {
        print('  updating routine ${index + 1} of $length...');
        routine.exerciseReferences = routine.exerciseReferences
            .map(
              (exerciseReference) => myExercises.doc(exerciseReference.id),
            )
            .toList();

        myRoutines.doc(routine.reference!.id).set(routine);
        print('  done.');
      },
    );
    print('done.');

    print('traversing myPerformances...');
    await traverse(
      myPerformances,
      (performance, index, length) async {
        print(
            '  updating performance ${performance.reference!.id} (${index + 1} of $length)...');
        if (performance is ExercisePerformance) {
          print('    updating exercisePerformance...');
          performance.exercise = ExerciseSnapshot(
            performance.exercise.snapshot,
            reference: myExercises.doc(
              performance.exercise.reference.id,
            ),
          );

          myPerformances.doc(performance.reference!.id).set(performance);
          print('    done.');
        } else if (performance is RoutinePerformance) {
          print('    updating routinePerformance...');
          performance.routine.exerciseReferences =
              performance.routine.exerciseReferences
                  .map(
                    (exerciseReference) =>
                        myExercises.doc(exerciseReference.id),
                  )
                  .toList();

          myPerformances.doc(performance.reference!.id).set(performance);
          print('    done.');

          print('    traversing routinePerformancePerformances...');
          await traverse(
            performance.performancesCollection!,
            (subPerformance, index, length) async {
              print(
                  '      updating exercisePerformance ${subPerformance.reference!.id} (${index + 1} of $length)...');
              subPerformance.exercise = ExerciseSnapshot(
                subPerformance.exercise.snapshot,
                reference: myExercises.doc(
                  subPerformance.exercise.reference.id,
                ),
              );

              performance.performancesCollection!
                  .doc(subPerformance.reference!.id)
                  .set(subPerformance);
              print('      done.');
            },
          );
          print('    done.');
        } else {
          print('    nothing to do...');
        }
        print('  done.');
      },
    );
    print('done.');
  }
}
