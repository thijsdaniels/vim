import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/collection.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/performances.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/food/consumptions.dart';
import 'package:vim/models/food/ingredients.dart';
import 'package:vim/models/food/recipes.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/services/exercises_service.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/services/recipes_service.dart';
import 'package:vim/services/routines_service.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/views/home_view.dart';
import 'package:vim/widgets/views/login_view.dart';

class Vim extends StatelessWidget {
  const Vim({super.key});

  @override
  Widget build(BuildContext context) {
    return Providers(
      child: Consumer<SettingsModel>(
        builder: (context, themeModel, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vim',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
              brightness: Brightness.light,
            ),
            fontFamily: 'GoogleSans',
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
            shadowColor: Colors.transparent,
            cardTheme: const CardTheme(
              shadowColor: Colors.transparent,
              margin: EdgeInsets.zero,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.dark,
              seedColor: Colors.deepPurple,
            ),
            fontFamily: 'GoogleSans',
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
            shadowColor: Colors.transparent,
            cardTheme: const CardTheme(
              shadowColor: Colors.transparent,
              margin: EdgeInsets.zero,
            ),
          ),
          themeMode: themeModel.mode,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) =>
                snapshot.hasData ? const HomeView() : const LoginView(),
          ),
        ),
      ),
    );
  }
}

class Providers extends StatelessWidget {
  final Widget child;

  const Providers({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context) => IngredientsService.all(),
          initialData: const Ingredients([]),
        ),
        StreamProvider(
          create: (context) => RecipesService.all(),
          initialData: const Recipes([]),
        ),
        StreamProvider<Collection<Exercise>>(
          create: (context) => ExercisesService.instance.all(),
          initialData: const Collection(),
        ),
        StreamProvider<Iterable<Routine>>(
          create: (context) => RoutinesService.all(),
          initialData: const [],
        ),
        ChangeNotifierProvider(
          create: (context) => DateModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingsModel(),
        ),
      ],
      child: Consumer<DateModel>(
        builder: (context, dateModel, _) => MultiProvider(
          providers: [
            StreamProvider.value(
              value: ConsumptionsService.forDate(dateModel.date),
              initialData: const Consumptions([]),
            ),
            StreamProvider.value(
              value: PerformancesService.instance.forDate(dateModel.date),
              initialData: const Performances([]),
            ),
          ],
          child: child,
        ),
      ),
    );
  }
}

class SettingsModel extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  Icons8Style _style = Icons8Style.stickers;

  ThemeMode get mode => _mode;

  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  Icons8Style get style => _style;

  set style(Icons8Style style) {
    _style = style;
    notifyListeners();
  }
}
