import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/surface.dart';

class FloatingActionSurface extends StatelessWidget {
  const FloatingActionSurface({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final void Function() onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Surface(
        isPrimary: true,
        child: SizedBox(
          width: 54,
          height: 54,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
