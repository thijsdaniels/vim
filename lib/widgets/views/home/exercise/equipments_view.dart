import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/list_surface.dart';
import 'package:vim/widgets/views/home/exercise/equipments/create_equipment_view.dart';
import 'package:vim/widgets/views/home/exercise/equipments/equipment_view.dart';

class EquipmentsView extends StatelessWidget {
  const EquipmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionSurface(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateEquipmentView(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer<List<Equipment>>(
          builder: (context, equipments, child) => StandardList(
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
          ),
        ),
      ),
    );
  }
}
