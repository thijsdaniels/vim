import 'package:flutter/material.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/exercise/equipments/equipment_view.dart';

class EquipmentsList extends StatelessWidget {
  const EquipmentsList(this.equipments, {super.key});

  final List<Equipment> equipments;

  @override
  Widget build(BuildContext context) {
    return StandardList(
      spacing: 12,
      itemCount: equipments.length,
      itemBuilder: (context, index) {
        Equipment equipment = equipments[index];

        return ListSurface(
          // icon: EquipmentIcon(equipment),
          title: equipment.name,
          // subtitle: equipment.type.name.toTitleCase(),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    EquipmentView(id: equipment.reference!.id),
              ),
            );
          },
        );
      },
    );
  }
}
