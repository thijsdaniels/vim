import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
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
import 'package:vim/models/settings_model.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/consumptions_collection.dart';
import 'package:vim/services/equipments_collection.dart';
import 'package:vim/services/exercises_collection.dart';
import 'package:vim/services/ingredients_collection.dart';
import 'package:vim/services/performances_collection.dart';
import 'package:vim/services/recipes_collection.dart';
import 'package:vim/services/routines_collection.dart';
import 'package:vim/services/users_collection.dart';
import 'package:vim/views/log/log_view.dart';
import 'package:vim/views/login_view.dart';
import 'package:vim/views/onboarding_view.dart';

class Vim extends StatelessWidget {
  const Vim({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateProviders(
      child: WithAuthentication(
        builder: (context, isAuthenticated, isOnboarded, completeOnboarding) {
          return ServiceProviders(
            child: Consumer<SettingsModel>(
              builder: (context, settingsModel, _) => MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Vim',
                theme: lightTheme(settingsModel.color),
                darkTheme: darkTheme(settingsModel.color),
                themeMode: settingsModel.themeMode,
                home: !isAuthenticated
                    ? const LoginView()
                    : !isOnboarded
                        ? OnboardingView(onComplete: completeOnboarding)
                        : const LogView(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StateProviders extends StatelessWidget {
  final Widget child;

  const StateProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<FragmentProgram?>.value(
          initialData: null,
          value:
              FragmentProgram.fromAsset('assets/shaders/surface_shader.frag'),
        ),
        ChangeNotifierProvider<DateModel>.value(
          value: DateModel(),
        ),
        ChangeNotifierProvider<SettingsModel>.value(
          value: SettingsModel(),
        ),
      ],
      child: child,
    );
  }
}

var lightTheme = (Color seedColor) => theme(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: seedColor,
      ),
    );

var darkTheme = (Color seedColor) => theme(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: seedColor,
      ),
    );

var theme = ({
  required ColorScheme colorScheme,
}) =>
    ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'GoogleSans',
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      cardColor: Colors.black,
      sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
      ),
    );

/// This widget handles the authentication flow and determines whether to show the
/// login, onboarding, or main application screen. It is now a stateless widget
/// that reactively listens to authentication and user profile changes.
class WithAuthentication extends StatelessWidget {
  const WithAuthentication({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    bool isAuthenticated,
    bool isOnboarded,
    void Function(User user) completeOnboarding,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_auth.User?>(
      stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final firebaseUser = authSnapshot.data;

        if (firebaseUser == null) {
          // User is not logged in.
          return builder(context, false, false, (_) {});
        }

        // User is logged in, now check for the user profile in Firestore.
        return StreamBuilder<User?>(
          stream: UsersCollection.instance.get(firebaseUser.uid),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final user = userSnapshot.data;

            if (user == null) {
              // User is authenticated but has no profile, needs to onboard.
              return builder(
                context,
                true,
                false,
                (newUser) => UsersCollection.instance.create(
                  newUser,
                  id: firebaseUser.uid,
                ),
              );
            }

            // User is authenticated and onboarded.
            return StreamProvider<User?>.value(
              initialData: user,
              value: UsersCollection.instance.get(firebaseUser.uid),
              child: builder(context, true, true, (_) {}),
            );
          },
        );
      },
    );
  }
}

class ServiceProviders extends StatelessWidget {
  final Widget child;

  const ServiceProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<User?>(
      builder: (context, user, _) {
        if (user == null) {
          return child;
        }

        return MultiProvider(
          providers: [
            Provider<IngredientsCollection>.value(
              value: IngredientsCollection(
                path: 'users/${user.reference!.id}/ingredients',
              ),
            ),
            Provider<RecipesCollection>.value(
              value: RecipesCollection(
                path: 'users/${user.reference!.id}/recipes',
              ),
            ),
            Provider<EquipmentsCollection>.value(
              value: EquipmentsCollection(
                path: 'users/${user.reference!.id}/equipments',
              ),
            ),
            Provider<ExercisesCollection>.value(
              value: ExercisesCollection(
                path: 'users/${user.reference!.id}/exercises',
              ),
            ),
            Provider<RoutinesCollection>.value(
              value: RoutinesCollection(
                path: 'users/${user.reference!.id}/routines',
              ),
            ),
            Provider<ConsumptionsCollection>.value(
              value: ConsumptionsCollection(
                path: 'users/${user.reference!.id}/consumptions',
              ),
            ),
            Provider<PerformancesCollection>.value(
              value: PerformancesCollection(
                path: 'users/${user.reference!.id}/performances',
              ),
            ),
          ],
          child: DataProviders(child: child),
        );
      },
    );
  }
}

class DataProviders extends StatelessWidget {
  final Widget child;

  const DataProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DateModel>(
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
            value: ConsumptionsCollection.of(context).forDate(dateModel.date),
            initialData: const [],
          ),
          StreamProvider<List<Performance>>.value(
            value: PerformancesCollection.of(context).forDate(dateModel.date),
            initialData: const [],
          ),
        ],
        child: child,
      ),
    );
  }
}
