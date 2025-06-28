import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/floating_action_surface.dart';
import 'package:vim/widgets/molecules/app_drawer.dart';
import 'package:vim/widgets/molecules/equipments_list.dart';

class EquipmentsView extends StatelessWidget {
  const EquipmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Consumer<List<Equipment>>(
          builder: (context, equipments, child) => EquipmentsList(equipments),
        ),
      ),
      floatingActionButton: FloatingActionSurface(
        onPressed: () {
          final user = User.of(context);
          context.push('/users/${user.reference!.id}/equipments/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
