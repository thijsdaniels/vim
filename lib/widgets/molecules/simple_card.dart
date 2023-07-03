import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/surface.dart';

class SimpleCard extends StatelessWidget {
  final bool primary;
  final String? title;
  final List<Widget>? actions;
  final Widget child;
  final double? elevation;

  const SimpleCard({
    super.key,
    this.primary = false,
    this.title,
    this.actions,
    this.elevation,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Surface(
      elevation: elevation,
      isPrimary: primary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                if (actions != null) Row(children: actions!),
              ],
            ),
            if (title != null || actions != null) const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
