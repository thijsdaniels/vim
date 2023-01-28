import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  final String text;
  const Subtitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
    );
  }
}
