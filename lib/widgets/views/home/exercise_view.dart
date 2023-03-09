import 'package:flutter/material.dart';
import 'package:vim/widgets/views/home/exercise/equipments_view.dart';
import 'package:vim/widgets/views/home/exercise/exercises_view.dart';
import 'package:vim/widgets/views/home/exercise/routines_view.dart';

class ExerciseView extends StatelessWidget {
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Exercises'),
              Tab(text: 'Routines'),
              Tab(text: 'Equipment'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ExercisesView(),
            RoutinesView(),
            EquipmentsView(),
          ],
        ),
      ),
    );
  }
}
