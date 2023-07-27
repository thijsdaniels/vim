import 'package:flutter/material.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/widgets/atoms/routine_icon.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/views/home/exercise/routines/routine_view.dart';

class RoutinesList extends StatelessWidget {
  const RoutinesList(this.routines, {super.key});

  final List<Routine> routines;

  @override
  Widget build(BuildContext context) {
    return StandardList(
      spacing: 12,
      itemCount: routines.length,
      itemBuilder: (context, index) {
        Routine routine = routines.elementAt(index);

        return ListSurface(
          icon: RoutineIcon(routine: routine),
          title: routine.name,
          subtitle: [
            '${routine.exerciseReferences.length} Exercises',
          ].join(" • "),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RoutineView(id: routine.reference!.id),
              ),
            );
          },
        );
      },
    );
  }
}
