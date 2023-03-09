import 'package:flutter/material.dart';
import 'package:vim/widgets/molecules/date_stepper.dart';
import 'package:vim/widgets/views/home/log/log_consumptions_view.dart';
import 'package:vim/widgets/views/home/log/log_performances_view.dart';
import 'package:vim/widgets/views/home/log/log_progress_view.dart';

class LogView extends StatelessWidget {
  const LogView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Log'),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: DateStepper(),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Status'),
              Tab(text: 'Consumptions'),
              Tab(text: 'Performances'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LogProgressView(),
            LogConsumptionsView(),
            LogPerformancesView(),
          ],
        ),
      ),
    );
  }
}
