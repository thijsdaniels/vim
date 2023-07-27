import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/services/performances_collection.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/molecules/performances_list.dart';
import 'package:vim/views/home/log/exercise_log/create_performance_view.dart';

class LogPerformancesView extends StatelessWidget {
  const LogPerformancesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionSurface(
        /// TODO: Instead of going to a new view just to render a `SearchAnchor`
        /// widget, which again renders its own view to show search results, I
        /// should just open the `SearchAnchor` directly from here. This does
        /// mean I need to find a new location for the "Quick Track" button.
        onPressed: () async {
          Performance? performance = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreatePerformanceView(),
            ),
          );

          if (performance != null) {
            PerformancesCollection.of(context).create(performance);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<List<Performance>>(
        builder: (context, performances, _) => PerformancesList(
          performances: performances,
        ),
      ),
    );
  }
}
