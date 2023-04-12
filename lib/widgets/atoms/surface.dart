import 'package:flutter/material.dart';

class Surface extends Card {
  const Surface({super.key, super.child, super.elevation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 16,
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: Card(
        elevation: elevation,
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}
