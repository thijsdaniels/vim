import 'package:flutter/material.dart';

/// TODO: I should probably turn this into a `TextTheme` entry or something.
class SecondaryText extends StatelessWidget {
  const SecondaryText(this.text, {super.key, this.textAlign});

  final String text;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        fontSize: 14,
      ),
    );
  }
}
