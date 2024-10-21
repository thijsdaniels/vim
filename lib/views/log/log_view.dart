import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/date_time.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/views/log/log_consumptions_view.dart';
import 'package:vim/views/log/log_performances_view.dart';
import 'package:vim/views/log/log_progress_view.dart';
import 'package:vim/widgets/molecules/app_drawer.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateModel dateModel = Provider.of<DateModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: LogTitle(date: dateModel.date),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: dateModel.previous,
          ),
          if (!dateModel.date.isToday())
            IconButton(
              icon: const Icon(Icons.today),
              onPressed: dateModel.today,
            ),
          if (dateModel.date.isToday())
            IconButton(
              icon: const Icon(Icons.edit_calendar),
              onPressed: () => {},
            ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: dateModel.next,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: [
          LogProgressView(),
          LogConsumptionsView(),
          LogPerformancesView(),
        ][_selectedIndex],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.book),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant),
            label: 'Food',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Exercise',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
      ),
    );
  }
}

class LogTitle extends StatelessWidget {
  const LogTitle({
    super.key,
    required this.date,
  });

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Text(
      date.isToday()
          ? 'Today'
          : date.isTomorrow()
              ? 'Tomorrow'
              : date.isYesterday()
                  ? 'Yesterday'
                  : date.year == DateTime.now().year
                      ? DateFormat.MMMMd('en_US').format(date)
                      : date.toDateString(),
    );
  }
}
