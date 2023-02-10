import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/exercise/routines.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
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
        child: Consumer<Routines>(
          builder: (context, routines, child) => ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: routines.length,
            itemBuilder: (context, index) {
              Routine routine = routines.get(index);

              return Card(
                child: ListTile(
                  title: Text(routine.name),
                  subtitle: FutureBuilder(
                    future: routine.calories,
                    builder: (context, snapshot) {
                      return SecondaryText(
                        [
                          if (snapshot.hasData)
                            '${snapshot.data!.round()} kcal',
                        ].join(" • "),
                      );
                    },
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RoutineView(routine: routine),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
