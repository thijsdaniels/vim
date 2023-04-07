import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/surface_list.dart';
import 'package:vim/widgets/views/home/exercise/routines/create_routine_view.dart';
import 'package:vim/widgets/views/home/exercise/routines/routine_view.dart';

class RoutinesView extends StatefulWidget {
  const RoutinesView({super.key});

  @override
  State<RoutinesView> createState() => _RoutinesViewState();
}

class _RoutinesViewState extends State<RoutinesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
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
        child: Consumer<Iterable<Routine>>(
          builder: (context, routines, child) => SurfaceList(
            itemCount: routines.length,
            itemBuilder: (context, index) {
              Routine routine = routines.elementAt(index);

              return ListTile(
                title: Text(routine.name),
                subtitle: SecondaryText(
                  [
                    '${routine.exerciseReferences.length} exercises',
                  ].join(" • "),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => RoutineView(routine.id!),
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
