import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vim/services/users_collection.dart';
import 'package:vim/views/equipments/create_equipment_view.dart';
import 'package:vim/views/equipments/equipment_view.dart';
import 'package:vim/views/equipments/equipments_view.dart';
import 'package:vim/views/exercises/create_exercise_view.dart';
import 'package:vim/views/exercises/exercise_view.dart';
import 'package:vim/views/exercises/exercises_view.dart';
import 'package:vim/views/ingredients/create_ingredient_view.dart';
import 'package:vim/views/ingredients/ingredient_view.dart';
import 'package:vim/views/ingredients/ingredients_view.dart';
import 'package:vim/views/log/exercise_log/performance_view.dart';
import 'package:vim/views/log/food_log/consumption_view.dart';
import 'package:vim/views/log/log_view.dart';
import 'package:vim/views/login_view.dart';
import 'package:vim/views/onboarding_view.dart';
import 'package:vim/views/recipes/create_recipe_view.dart';
import 'package:vim/views/recipes/recipe_view.dart';
import 'package:vim/views/recipes/recipes_view.dart';
import 'package:vim/views/routines/create_routine_view.dart';
import 'package:vim/views/routines/routine_view.dart';
import 'package:vim/views/routines/routines_view.dart';
import 'package:vim/views/settings_view.dart';
import 'package:vim/widgets/molecules/authenticated_shell.dart';

final router = GoRouter(
  refreshListenable:
      GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
  redirect: (context, state) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    final isLoggingIn = state.matchedLocation == '/login';

    if (firebaseUser == null && !isLoggingIn) {
      return '/login';
    }

    if (firebaseUser == null) {
      return null;
    }

    final user = await UsersCollection.instance.get(firebaseUser.uid).first;
    final isOnboarding = state.matchedLocation == '/onboarding';

    if (user == null && !isOnboarding) {
      return '/onboarding';
    }

    if (isLoggingIn || isOnboarding) {
      return '/';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/log',
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => OnboardingView(
        onComplete: (user) {
          final firebaseUser = FirebaseAuth.instance.currentUser;
          if (firebaseUser != null) {
            UsersCollection.instance.create(user, id: firebaseUser.uid);
          }
        },
      ),
    ),
    ShellRoute(
        builder: (context, state, child) => AuthenticatedShell(child: child),
        routes: [
          GoRoute(
            path: '/log',
            builder: (context, state) => const LogView(),
          ),
          GoRoute(
            path: '/equipments',
            builder: (context, state) => const EquipmentsView(),
          ),
          GoRoute(
            path: '/exercises',
            builder: (context, state) => const ExercisesView(),
          ),
          GoRoute(
            path: '/ingredients',
            builder: (context, state) => const IngredientsView(),
          ),
          GoRoute(
            path: '/recipes',
            builder: (context, state) => const RecipesView(),
          ),
          GoRoute(
            path: '/routines',
            builder: (context, state) => const RoutinesView(),
          ),
          GoRoute(
              path: '/users',
              builder: (context, state) =>
                  const PlaceholderView(message: 'Users List View'),
              routes: [
                GoRoute(
                    path: ':userId',
                    builder: (context, state) => PlaceholderView(
                        message:
                            'User Detail View for ${state.pathParameters['userId']}'),
                    routes: [
                      GoRoute(
                        path: 'equipments',
                        builder: (context, state) => const PlaceholderView(
                            message: 'User-specific Equipments List'),
                        routes: [
                          GoRoute(
                            path: 'create',
                            builder: (context, state) =>
                                const CreateEquipmentView(),
                          ),
                          GoRoute(
                            path: ':equipmentId',
                            builder: (context, state) => EquipmentView(
                                path: state.matchedLocation.substring(1)),
                          )
                        ],
                      ),
                      GoRoute(
                        path: 'exercises',
                        builder: (context, state) => const PlaceholderView(
                            message: 'User-specific Exercises List'),
                        routes: [
                          GoRoute(
                            path: 'create',
                            builder: (context, state) =>
                                const CreateExerciseView(),
                          ),
                          GoRoute(
                            path: ':exerciseId',
                            builder: (context, state) => ExerciseView(
                                path: state.matchedLocation.substring(1)),
                          )
                        ],
                      ),
                      GoRoute(
                        path: 'ingredients',
                        builder: (context, state) => const PlaceholderView(
                            message: 'User-specific Ingredients List'),
                        routes: [
                          GoRoute(
                            path: 'create',
                            builder: (context, state) =>
                                const CreateIngredientView(),
                          ),
                          GoRoute(
                            path: ':ingredientId',
                            builder: (context, state) => IngredientView(
                                path: state.matchedLocation.substring(1)),
                          )
                        ],
                      ),
                      GoRoute(
                        path: 'recipes',
                        builder: (context, state) => const PlaceholderView(
                            message: 'User-specific Recipes List'),
                        routes: [
                          GoRoute(
                            path: 'create',
                            builder: (context, state) =>
                                const CreateRecipeView(),
                          ),
                          GoRoute(
                            path: ':recipeId',
                            builder: (context, state) => RecipeView(
                                path: state.matchedLocation.substring(1)),
                          )
                        ],
                      ),
                      GoRoute(
                        path: 'routines',
                        builder: (context, state) => const PlaceholderView(
                            message: 'User-specific Routines List'),
                        routes: [
                          GoRoute(
                            path: 'create',
                            builder: (context, state) =>
                                const CreateRoutineView(),
                          ),
                          GoRoute(
                            path: ':routineId',
                            builder: (context, state) => RoutineView(
                                path: state.matchedLocation.substring(1)),
                          )
                        ],
                      ),
                      GoRoute(
                          path: 'consumptions/:consumptionId',
                          builder: (context, state) => ConsumptionView(
                              path: state.matchedLocation.substring(1))),
                      GoRoute(
                          path: 'performances/:performanceId',
                          builder: (context, state) => PerformanceView(
                              path: state.matchedLocation.substring(1))),
                    ]),
              ]),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsView(),
          ),
        ]),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class PlaceholderView extends StatelessWidget {
  const PlaceholderView({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text(message)));
}
