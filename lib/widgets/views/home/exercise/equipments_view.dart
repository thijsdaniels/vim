import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';

class EquipmentsView extends StatelessWidget {
  const EquipmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionSurface(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
