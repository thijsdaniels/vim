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
import 'package:vim/models/user/user.dart';
import 'package:vim/models/settings_model.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/services/routines_service.dart';
import 'package:vim/services/users_service.dart';
import 'package:vim/widgets/views/home_view.dart';
import 'package:vim/widgets/views/login_view.dart';

class Vim extends StatelessWidget {
  const Vim({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateProviders(
      child: Consumer<SettingsModel>(
        builder: (context, settingsModel, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Vim',
            theme: lightTheme(settingsModel.color),
            darkTheme: darkTheme(settingsModel.color),
            themeMode: settingsModel.themeMode,
            home: WithAuthentication(
              loginBuilder: (context) => const LoginView(),
              authenticatedBuilder: (context) => const ServiceProviders(
                child: DataProviders(
                  child: HomeView(),
                ),
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
    );

class WithAuthentication extends StatelessWidget {
  const WithAuthentication({
    super.key,
    required this.authenticatedBuilder,
    required this.loginBuilder,
  });

  final Widget Function(BuildContext context) authenticatedBuilder;
  final Widget Function(BuildContext context) loginBuilder;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<firebase_auth.User?>(
      stream: firebase_auth.FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? StreamProvider<User?>.value(
                initialData: null,
                value: UsersService.instance.get(snapshot.data!.uid),
                child: authenticatedBuilder(context),
              )
            : loginBuilder(context);
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
          return const Center(child: CircularProgressIndicator());
        }

        return MultiProvider(
          providers: [
            Provider<ConsumptionsService>.value(
              value: ConsumptionsService(user),
            ),
            Provider<PerformancesService>.value(
              value: PerformancesService(user),
            ),
          ],
          child: child,
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
            value: IngredientsService.instance.all(),
            initialData: const [],
          ),
          StreamProvider<List<Recipe>>.value(
            value: RecipesService.instance.all(),
            initialData: const [],
          ),
          StreamProvider<List<Exercise>>.value(
            value: ExercisesService.instance.all(),
            initialData: const [],
          ),
          StreamProvider<List<Routine>>.value(
            value: RoutinesService.instance.all(),
            initialData: const [],
          ),
          StreamProvider<List<Consumption>>.value(
            value: ConsumptionsService.of(context).forDate(dateModel.date),
            initialData: const [],
          ),
          StreamProvider<List<Performance>>.value(
            value: PerformancesService.of(context).forDate(dateModel.date),
            initialData: const [],
          ),
        ],
        child: child,
      ),
    );
  }
}
