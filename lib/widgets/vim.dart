import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/consumptions.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/ingredients.dart';
import 'package:vim/models/performances.dart';
import 'package:vim/models/recipes.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/services/recipes_service.dart';
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
            fontFamily: 'GoogleSans',
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            fontFamily: 'GoogleSans',
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
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
        StreamProvider<Ingredients>(
            create: (context) => IngredientsService.all(),
            initialData: Ingredients([])),
        StreamProvider<Recipes>(
          create: (context) => RecipesService.all(),
          initialData: Recipes([]),
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
              initialData: Consumptions([]),
            ),
            StreamProvider.value(
              value: PerformancesService.forDate(dateModel.date),
              initialData: Performances([]),
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
