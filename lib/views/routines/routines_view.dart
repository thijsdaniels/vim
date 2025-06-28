import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/user/user.dart';
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
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Consumer<List<Routine>>(
          builder: (context, routines, child) => RoutinesList(routines),
        ),
      ),
      floatingActionButton: FloatingActionSurface(
        onPressed: () {
          final user = User.of(context);
          context.push('/users/${user.reference!.id}/routines/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
