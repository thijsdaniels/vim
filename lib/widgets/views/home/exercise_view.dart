import 'package:flutter/material.dart';
import 'package:vim/widgets/views/home/exercise/exercises_view.dart';
import 'package:vim/widgets/views/home/exercise/routines_view.dart';

class ExerciseView extends StatefulWidget {
  const ExerciseView({super.key});

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise'),
          bottom: TabBar(
            tabs: const [
              Tab(
                icon: Icon(Icons.sports_gymnastics),
                text: 'Exercises',
              ),
              Tab(
                icon: Icon(Icons.assignment),
                text: 'Routines',
              ),
              Tab(
                icon: Icon(Icons.fitness_center),
                text: 'Equipment',
              ),
            ],
            onTap: _onTap,
          ),
        ),
        body: [
          const ExercisesView(),
          const RoutinesView(),
          Column(),
        ][_selectedIndex],
      ),
    );
  }
}
