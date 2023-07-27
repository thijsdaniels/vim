import 'package:flutter/material.dart';
import 'package:vim/views/home/exercise/equipments_view.dart';
import 'package:vim/views/home/exercise/exercises_view.dart';
import 'package:vim/views/home/exercise/routines_view.dart';

class ExerciseView extends StatelessWidget {
  const ExerciseView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Routines'),
              Tab(text: 'Exercises'),
              Tab(text: 'Equipment'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            RoutinesView(),
            ExercisesView(),
            EquipmentsView(),
          ],
        ),
      ),
    );
  }
}
