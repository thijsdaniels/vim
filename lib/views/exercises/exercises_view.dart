import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/molecules/app_drawer.dart';
import 'package:vim/widgets/molecules/exercises_list.dart';

class ExercisesView extends StatelessWidget {
  const ExercisesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Consumer<List<Exercise>>(
          builder: (context, exercises, child) => ExercisesList(exercises),
        ),
      ),
      floatingActionButton: FloatingActionSurface(
        onPressed: () {
          final user = User.of(context);
          context.push('/users/${user.reference!.id}/exercises/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
