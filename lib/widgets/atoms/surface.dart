import 'package:flutter/material.dart';

class Surface extends Card {
  final double? width;
  final double? height;
  final bool primary;

  const Surface({
    super.key,
    super.child,
    super.elevation,
    super.shape,
    this.width,
    this.height,
    this.primary = false,
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
        elevation: primary ? 0 : elevation,
        clipBehavior: Clip.antiAlias,
        child: primary
            ? Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.purple[800]!,
                      Colors.deepPurple[700]!,
                    ],
                    stops: const [0, 1],
                  ),
                ),
                child: child,
              )
            : child,
      ),
    );
  }
}
