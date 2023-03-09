import 'package:flutter/material.dart';

class EquipmentsView extends StatefulWidget {
  const EquipmentsView({super.key});

  @override
  State<EquipmentsView> createState() => _EquipmentsViewState();
}

class _EquipmentsViewState extends State<EquipmentsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
