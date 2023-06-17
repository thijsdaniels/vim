import 'package:flutter/material.dart';

class Surface extends Card {
  final double? width;
  final double? height;
  final bool isPrimary;

  const Surface({
    super.key,
    super.child,
    super.elevation,
    super.shape,
    this.width,
    this.height,
    this.isPrimary = false,
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
        clipBehavior: Clip.antiAlias,
        child: isPrimary
            // ? PrimarySurfacePaint(child: child) // TODO: Improve performance.
            ? Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: child,
              )
            : child,
      ),
    );
  }
}
