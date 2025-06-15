import 'package:flutter/material.dart';
import 'package:vim/models/food/consumption.dart';
import 'package:vim/widgets/atoms/consumption_list_surface.dart';
import 'package:vim/widgets/atoms/standard_list.dart';

class ConsumptionsList extends StatelessWidget {
  final List<Consumption> consumptions;
  final ScrollPhysics? physics;
  final EdgeInsets padding;
  final double? elevation;
  final bool showCalories;
  final bool showMacros;
  final bool showTime;

  const ConsumptionsList(
    this.consumptions, {
    super.key,
    this.physics,
    this.padding = const EdgeInsets.all(16.0),
    this.elevation,
    this.showCalories = false,
    this.showMacros = false,
    this.showTime = true,
  });

  @override
  Widget build(BuildContext context) {
    if (consumptions.isEmpty) {
      return Center(
        child: Icon(
          Icons.more_horiz,
          color:
              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.25),
        ),
      );
    }

    return StandardList(
      physics: physics,
      padding: padding,
      spacing: 12,
      itemCount: consumptions.length,
      itemBuilder: (context, index) {
        return ConsumptionListSurface(
          consumptions[index],
          elevation: elevation,
          showCalories: showCalories,
          showMacros: showMacros,
          showTime: showTime,
        );
      },
    );
  }
}
