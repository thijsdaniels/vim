import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/routines_service.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/views/home/exercise/routines/create_routine_view.dart';

class RoutineView extends StatefulWidget {
  final Routine routine;

  const RoutineView({
    super.key,
    required this.routine,
  });

  @override
  State<RoutineView> createState() => _RoutineViewState();
}

class _RoutineViewState extends State<RoutineView> {
  @override
  Widget build(BuildContext context) {
    Routine routine = widget.routine;

    return Scaffold(
      appBar: AppBar(
        title: Text(routine.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateRoutineView(
                    routine: routine,
                  ),
                ),
              );
            },
          ),
          WithConfirmationDialog(
            title: routine.name,
            description: 'Are you sure you want to delete this routine?',
            builder: (context, confirm) => IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () async {
                if (await confirm()) {
                  RoutinesService.delete(routine);

                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SimpleCard(
                title: 'Details',
                child: Table(
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  children: [
                    TableRow(
                      children: [
                        const SecondaryText('Name'),
                        const SizedBox(width: 32),
                        Text(routine.name),
                      ],
                    ),
                    TableRow(
                      children: [
                        const SecondaryText('Calories'),
                        const SizedBox(width: 32),
                        FutureBuilder(
                          future: routine.calories,
                          builder: (context, snapshot) {
                            return Row(
                              children: snapshot.hasData
                                  ? [
                                      Text(snapshot.data!.round().toString()),
                                      const SizedBox(width: 4),
                                      const SecondaryText('kcal')
                                    ]
                                  : [],
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SimpleCard(
                title: 'Exercises',
                child: Column(
                  children: routine.plan
                      .asMap()
                      .entries
                      .map(
                        (entry) => FutureBuilder(
                          future: entry.value.exercise,
                          builder: (context, snapshot) => Card(
                            elevation: 4,
                            child: ListTile(
                              leading: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.drag_handle),
                              ),
                              title: Text(snapshot.data?.name ?? ''),
                              subtitle: SecondaryText(
                                // TODO: Try to change this into Chip widgets.
                                [
                                  if (snapshot.data?.type ==
                                      ExerciseType.manual)
                                    '${entry.value.calories!.round()} cal',
                                  if (snapshot.data?.type ==
                                      ExerciseType.weights) ...[
                                    '${(entry.value.sets.weight / entry.value.sets.length)} kg',
                                    entry.value.sets
                                        .map(
                                          (set) => '${set.repetitions}',
                                        )
                                        .join("/"),
                                  ],
                                  if (snapshot.data?.type ==
                                      ExerciseType.resistance) ...[
                                    '${entry.value.watts!} watts',
                                    '${entry.value.minutes!} m',
                                  ],
                                ].join(" • "),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
