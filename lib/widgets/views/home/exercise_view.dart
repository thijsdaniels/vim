import 'package:flutter/material.dart';
import 'package:vim/widgets/views/home/exercise/equipments_view.dart';
import 'package:vim/widgets/views/home/exercise/exercises_view.dart';
import 'package:vim/widgets/views/home/exercise/plans_view.dart';
import 'package:vim/widgets/views/home/exercise/routines_view.dart';

class ExerciseView extends StatelessWidget {
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Equipment'),
              Tab(text: 'Exercises'),
              Tab(text: 'Routines'),
              Tab(text: 'Plans'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            EquipmentsView(),
            ExercisesView(),
            RoutinesView(),
            PlanssView(),
          ],
        ),
      ),
    );
  }
}
