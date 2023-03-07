import 'package:flutter/material.dart';
import 'package:vim/widgets/molecules/performances_list.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_performance_view.dart';

class ExerciseLogView extends StatelessWidget {
  const ExerciseLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreatePerformanceView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: PerformancesList(),
        ),
      ),
    );
  }
}
