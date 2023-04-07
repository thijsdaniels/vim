import 'package:flutter/material.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/services/performances_service.dart';
import 'package:vim/widgets/molecules/performances_list.dart';
import 'package:vim/widgets/views/home/log/exercise_log/create_performance_view.dart';

class LogPerformancesView extends StatelessWidget {
  const LogPerformancesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Performance? performance = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreatePerformanceView(),
            ),
          );

          if (performance != null) {
            PerformancesService.create(performance);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: const PerformancesList(),
    );
  }
}
