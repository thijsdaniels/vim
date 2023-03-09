import 'package:flutter/material.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_exercise_performance_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_quick_track_performance_view.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_routine_performance_view.dart';

class CreatePerformanceView extends StatefulWidget {
  const CreatePerformanceView({super.key});

  @override
  State<CreatePerformanceView> createState() => _CreatePerformanceViewState();
}

class _CreatePerformanceViewState extends State<CreatePerformanceView> {
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
        bottomNavigationBar: TabBar(
          tabs: const [
            Tab(text: 'Exercise'),
            Tab(text: 'Routine'),
            Tab(text: 'Quick Track'),
          ],
          onTap: _onTap,
        ),
        body: [
          const CreateExercisePerformanceView(),
          const CreateRoutinePerformanceView(),
          const CreateQuickTrackPerformanceView(),
        ][_selectedIndex],
      ),
    );
  }
}
