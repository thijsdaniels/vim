import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/exercise/exercises.dart';
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
import 'package:vim/widgets/views/home_view.dart';

class Vim extends StatelessWidget {
  const Vim({super.key});

  @override
  Widget build(BuildContext context) {
    return Providers(
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vim',
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            colorSchemeSeed: Colors.deepPurple,
            fontFamily: 'GoogleSans',
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
            shadowColor: Colors.transparent,
            cardTheme: const CardTheme(
              shadowColor: Colors.transparent,
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.deepPurple,
            fontFamily: 'GoogleSans',
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
            shadowColor: Colors.transparent,
            cardTheme: const CardTheme(
              shadowColor: Colors.transparent,
            ),
          ),
          themeMode: themeModel.mode,
          home: const HomeView(),
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
        StreamProvider(
          create: (context) => ExercisesService.instance.all(),
          initialData: const Exercises([]),
        ),
        StreamProvider<Iterable<Routine>>(
          create: (context) => RoutinesService.all(),
          initialData: const [],
        ),
        ChangeNotifierProvider(
          create: (context) => DateModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeModel(),
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
              value: PerformancesService.forDate(dateModel.date),
              initialData: const Performances([]),
            ),
          ],
          child: child,
        ),
      ),
    );
  }
}

class ThemeModel extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.dark;

  ThemeMode get mode => _mode;

  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }
}
