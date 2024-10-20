import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/views/routines/create_routine_view.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/molecules/app_drawer.dart';
import 'package:vim/widgets/molecules/routines_list.dart';

class RoutinesView extends StatelessWidget {
  const RoutinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routines'),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionSurface(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateRoutineView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<List<Routine>>(
          builder: (context, routines, child) => RoutinesList(routines),
        ),
      ),
    );
  }
}
