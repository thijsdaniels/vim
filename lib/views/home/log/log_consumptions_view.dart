import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/molecules/consumptions_list.dart';
import 'package:vim/views/home/log/food_log/create_consumption_view.dart';

class LogConsumptionsView extends StatelessWidget {
  const LogConsumptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionSurface(
        /// TODO: Instead of going to a new view just to render a `SearchAnchor`
        /// widget, which again renders its own view to show search results, I
        /// should just open the `SearchAnchor` directly from here. This does
        /// mean I need to find a new location for the "Quick Track" button.
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateConsumptionView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<List<Consumption>>(
        builder: (context, consumptions, _) {
          return ConsumptionsList(consumptions);
        },
      ),
    );
  }
}
