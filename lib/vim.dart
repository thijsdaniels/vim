import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
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
import 'package:vim/views/home_view.dart';
import 'package:vim/views/login_view.dart';
import 'package:vim/views/onboarding_view.dart';

import 'models/exercise/equipment.dart';

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
                        : const HomeView(),
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

/// TODO: I'm currently setting an onboardingCompleted state just to make the
/// widget rebuild and check if there is a `User` instance now. I don't like
/// this solution, I think the creation of a `User` should automatically trigger
/// a rebuild, which means I should use a `StreamBuilder` instead of a
/// `FutureBuilder`. However, I haven't found a good way to check using a
/// `StreamBuilder` whether there actually _is_ an instance to stream at all,
/// hence my use of the `FutureBuilder` on the `stream.first`...
class WithAuthentication extends StatefulWidget {
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
  State<WithAuthentication> createState() => _WithAuthenticationState();
}

class _WithAuthenticationState extends State<WithAuthentication> {
  bool onboardingCompleted = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_auth.User?>(
      stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
      builder: (context, firebaseUserSnapshot) {
        if (!firebaseUserSnapshot.hasData) {
          return widget.builder(context, false, false, (user) => {});
        }

        return FutureBuilder(
          future: UsersCollection.instance
              .get(firebaseUserSnapshot.data!.uid)
              .first,
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (userSnapshot.data == null) {
              return widget.builder(
                context,
                true,
                false,
                (user) async {
                  await UsersCollection.instance.create(
                    user,
                    id: firebaseUserSnapshot.data!.uid,
                  );

                  setState(() => onboardingCompleted = true);
                },
              );
            }

            return StreamProvider<User?>.value(
              initialData: userSnapshot.data,
              value: UsersCollection.instance
                  .get(userSnapshot.data!.reference!.id),
              child: widget.builder(context, true, true, (user) => {}),
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
