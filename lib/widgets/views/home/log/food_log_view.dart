import 'package:flutter/material.dart';
import 'package:vim/widgets/molecules/consumptions_list.dart';
import 'package:vim/widgets/views/home/log/food_log/create_consumption_view.dart';

class FoodLogView extends StatelessWidget {
  const FoodLogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateConsumptionView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ConsumptionsList(),
        ),
      ),
    );
  }
}
