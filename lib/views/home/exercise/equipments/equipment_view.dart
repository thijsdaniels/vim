import 'package:flutter/material.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/equipments_collection.dart';
import 'package:vim/services/equipments_collection_group.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/stats_table.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/views/home/exercise/equipments/create_equipment_view.dart';
import 'package:vim/views/loading_view.dart';
import 'package:vim/views/not_found_view.dart';

class EquipmentView extends StatelessWidget {
  final String path;

  const EquipmentView({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Equipment?>(
      stream: EquipmentsCollectionGroup.instance.get(path),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingView();
        }

        if (!snapshot.hasData) {
          return const NotFoundView();
        }

        Equipment equipment = snapshot.requireData!;

        return Scaffold(
          appBar: AppBar(
            title: Text(equipment.name),
            actions: [
              if (equipment.reference!.parent.parent!.id ==
                  User.of(context).reference!.id) ...[
                IconButton(
                  icon: const Icon(Icons.edit_rounded),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateEquipmentView(
                          equipment: equipment,
                        ),
                      ),
                    );
                  },
                ),
                WithConfirmationDialog(
                  title: equipment.name,
                  description:
                      'Are you sure you want to delete this equipment?',
                  builder: (context, confirm) => IconButton(
                    icon: const Icon(Icons.delete_rounded),
                    onPressed: () async {
                      var navigator = Navigator.of(context);
                      if (await confirm()) {
                        EquipmentsCollection.of(context).delete(equipment);
                        navigator.pop();
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
          body: StandardList(
            children: [
              SimpleCard(
                title: 'Details',
                child: StatsTable(
                  children: [
                    StatsRow('Name', equipment.name),
                    // StatsRow(
                    //   'Base Weight',
                    //   equipment.baseWeight.kilograms.toString(),
                    //   unit: 'kg',
                    // ),
                    StatsRow(
                      'Weight Increment',
                      equipment.weightIncrement.kilograms.toString(),
                      unit: 'kg',
                    ),
                    // StatsRow('Load Factor', equipment.loadFactor.toString()),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
