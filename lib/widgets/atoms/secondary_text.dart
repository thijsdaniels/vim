import 'package:flutter/material.dart';

class SecondaryText extends StatelessWidget {
  final String text;
  const SecondaryText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        fontSize: 14,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
