import 'package:flutter/material.dart';

import 'surface.dart';

class SurfaceList extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;
  final ScrollPhysics? physics;

  const SurfaceList({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      shrinkWrap: true,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Surface(
          child: itemBuilder(context, index),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}
