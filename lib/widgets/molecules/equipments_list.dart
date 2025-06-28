import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class EquipmentsList extends StatelessWidget {
  const EquipmentsList(
    this.equipments, {
    super.key,
    this.elevation,
    this.physics,
    this.padding = const EdgeInsets.all(16),
  });

  final List<Equipment> equipments;
  final double? elevation;
  final ScrollPhysics? physics;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return StandardList(
      spacing: 12,
      physics: physics,
      padding: padding,
      itemCount: equipments.length,
      itemBuilder: (context, index) {
        final equipment = equipments[index];
        return ListSurface(
          elevation: elevation,
          // icon: EquipmentIcon(equipment),
          title: equipment.name,
          // subtitle: equipment.type.name.toTitleCase(),
          onTap: () => context.push('/${equipment.reference!.path}'),
        );
      },
    );
  }
}
