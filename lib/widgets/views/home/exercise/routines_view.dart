import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/atoms/routine_icon.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/exercise/routines/create_routine_view.dart';
import 'package:vim/widgets/views/home/exercise/routines/routine_view.dart';

class RoutinesView extends StatelessWidget {
  const RoutinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          builder: (context, routines, child) => StandardList(
            itemCount: routines.length,
            itemBuilder: (context, index) {
              Routine routine = routines.elementAt(index);

              return ListSurface(
                icon: RoutineIcon(routine: routine),
                title: Text(routine.name),
                subtitle: SecondaryText(
                  [
                    '${routine.exerciseReferences.length} exercises',
                  ].join(" • "),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RoutineView(routine.reference!.id),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
