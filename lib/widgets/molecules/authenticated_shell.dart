import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/ingredient.dart';
import 'package:vim/models/food/recipe.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/consumptions_collection.dart';
import 'package:vim/services/equipments_collection.dart';
import 'package:vim/services/exercises_collection.dart';
import 'package:vim/services/ingredients_collection.dart';
import 'package:vim/services/performances_collection.dart';
import 'package:vim/services/recipes_collection.dart';
import 'package:vim/services/routines_collection.dart';
import 'package:vim/services/users_collection.dart';

class AuthenticatedShell extends StatelessWidget {
  final Widget child;

  const AuthenticatedShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser == null) {
      // This should not happen due to the redirect, but it's a good safeguard.
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return StreamProvider<User?>.value(
      value: UsersCollection.instance.get(firebaseUser.uid),
      initialData: null,
      child: MultiProvider(
        providers: [
          Provider<IngredientsCollection>.value(
            value: IngredientsCollection(
              path: 'users/${firebaseUser.uid}/ingredients',
            ),
          ),
          Provider<RecipesCollection>.value(
            value: RecipesCollection(
              path: 'users/${firebaseUser.uid}/recipes',
            ),
          ),
          Provider<EquipmentsCollection>.value(
            value: EquipmentsCollection(
              path: 'users/${firebaseUser.uid}/equipments',
            ),
          ),
          Provider<ExercisesCollection>.value(
            value: ExercisesCollection(
              path: 'users/${firebaseUser.uid}/exercises',
            ),
          ),
          Provider<RoutinesCollection>.value(
            value: RoutinesCollection(
              path: 'users/${firebaseUser.uid}/routines',
            ),
          ),
          Provider<ConsumptionsCollection>.value(
            value: ConsumptionsCollection(
              path: 'users/${firebaseUser.uid}/consumptions',
            ),
          ),
          Provider<PerformancesCollection>.value(
            value: PerformancesCollection(
              path: 'users/${firebaseUser.uid}/performances',
            ),
          ),
        ],
        child: Consumer<DateModel>(
          builder: (context, dateModel, _) => MultiProvider(
            providers: [
              StreamProvider<List<Ingredient>>.value(
                value: IngredientsCollection.of(context).all(),
                initialData: const [],
              ),
              StreamProvider<List<Recipe>>.value(
                value: RecipesCollection.of(context).all(),
                initialData: const [],
              ),
              StreamProvider<List<Equipment>>.value(
                value: EquipmentsCollection.of(context).all(),
                initialData: const [],
              ),
              StreamProvider<List<Exercise>>.value(
                value: ExercisesCollection.of(context).all(),
                initialData: const [],
              ),
              StreamProvider<List<Routine>>.value(
                value: RoutinesCollection.of(context).all(),
                initialData: const [],
              ),
              StreamProvider<List<Consumption>>.value(
                value:
                    ConsumptionsCollection.of(context).forDate(dateModel.date),
                initialData: const [],
              ),
              StreamProvider<List<Performance>>.value(
                value:
                    PerformancesCollection.of(context).forDate(dateModel.date),
                initialData: const [],
              ),
            ],
            child: child,
          ),
        ),
      ),
    );
  }
}
