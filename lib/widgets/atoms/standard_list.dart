import 'package:flutter/material.dart';

class StandardList extends StatelessWidget {
  final int? itemCount;
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final List<Widget>? children;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double spacing;

  const StandardList({
    super.key,
    this.children,
    this.itemCount,
    this.itemBuilder,
    this.physics, //  = const NeverScrollableScrollPhysics(),
    this.padding = const EdgeInsets.all(16.0), // EdgeInsets.zero,
    this.spacing = 16,
  }) : assert(itemCount != null && itemBuilder != null || children != null);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: true,
      physics: physics,
      itemCount: itemCount != null ? itemCount! : children!.length,
      itemBuilder: itemBuilder != null
          ? itemBuilder!
          : (context, index) => children![index],
      separatorBuilder: (context, index) => SizedBox(height: spacing),
    );
  }
}
