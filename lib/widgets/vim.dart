import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/services/consumptions_service.dart';
import 'package:vim/services/ingredients_service.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/views/tabs.dart';

class Vim extends StatelessWidget {
  const Vim({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Ingredients>(
      create: (context) => IngredientsService.all(),
      initialData: Ingredients(List.empty()),
      child: ChangeNotifierProvider(
        create: (context) => DateModel(),
        child: Consumer<DateModel>(
          builder: (context, dateModel, child) => MultiProvider(
            providers: [
              StreamProvider.value(
                value: ConsumptionsService.forDate(dateModel.date),
                initialData: Consumptions(List.empty()),
              ),
              StreamProvider.value(
                value: PerformancesService.forDate(dateModel.date),
                initialData: Performances(List.empty()),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Vim',
              theme: ThemeData(
                primarySwatch: Colors.deepPurple,
              ),
              home: const Tabs(),
            ),
          ),
        ),
      ),
    );
  }
}
