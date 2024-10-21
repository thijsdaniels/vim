import 'package:flutter/material.dart';

class Surface extends Card {
  final double? width;
  final double? height;
  final bool isPrimary;
  final Emphasis emphasis;

  const Surface({
    super.key,
    super.child,
    super.elevation,
    super.shape,
    this.width,
    this.height,
    this.isPrimary = false,
    this.emphasis = Emphasis.low,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
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
          shape: shape,
          shadowColor: Colors.transparent,
          margin: EdgeInsets.zero,
          elevation: isPrimary ? 0 : elevation,
          color: isPrimary
              ? Theme.of(context).colorScheme.primaryContainer
              : getColor(emphasis, context),
          clipBehavior: Clip.antiAlias,
          child:
              child // isPrimary ? PrimarySurfacePaint(child: child) // TODO: Improve performance.
          ),
    );
  }

  Color getColor(Emphasis emphasis, BuildContext context) {
    switch (emphasis) {
      case Emphasis.highest:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
      case Emphasis.high:
        return Theme.of(context).colorScheme.surfaceContainerHigh;
      case Emphasis.medium:
        return Theme.of(context).colorScheme.surfaceContainer;
      case Emphasis.low:
        return Theme.of(context).colorScheme.surfaceContainerLow;
      case Emphasis.lowest:
        return Theme.of(context).colorScheme.surfaceContainerLowest;
    }
  }
}

enum Emphasis {
  highest,
  high,
  medium,
  low,
  lowest,
}
