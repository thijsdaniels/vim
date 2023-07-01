import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/surface.dart';

class DebugView extends StatelessWidget {
  const DebugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: const DebugMuscleMap(),
      // body: const MigrateButton(),
    );
  }
}

class DebugMuscleMap extends StatefulWidget {
  const DebugMuscleMap({super.key});

  @override
  State<DebugMuscleMap> createState() => _DebugMuscleMapState();
}

class _DebugMuscleMapState extends State<DebugMuscleMap> {
  bool _front = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Surface(
              isPrimary: true,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: MuscleMap(
                  view: _front ? MuscleMapView.front : MuscleMapView.back,
                  muscles: const {
                    MuscleGroup.chest: 1,
                    MuscleGroup.lats: 0.25,
                    MuscleGroup.abs: 0.75,
                    MuscleGroup.shoulders: 0.5,
                    MuscleGroup.lowerBack: 0.25,
                    MuscleGroup.glutes: 0.5,
                    MuscleGroup.hamstrings: 1,
                  },
                ),
              ),
            ),
          ),
          FilledButton(
            onPressed: () {
              setState(() {
                _front = !_front;
              });
            },
            child: const Text('Flip'),
          ),
        ],
      ),
    );
  }
}

// class MigrateButton extends StatelessWidget {
//   const MigrateButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FilledButton(
//       onPressed: migrate,
//       child: const Text('Migrate'),
//     );
//   }

//   Future<void> migrate() async {
//     print('running migration');

//     var publicConsumptionsCollection = ConsumptionsService(
//       path: 'consumptions',
//     );

//     var privateConsumptionsCollection = ConsumptionsService(
//       path: 'users/ZSBLclXCH8euEBERCPSNltS4Yvl2/consumptions',
//     );

//     var consumptions = await publicConsumptionsCollection.getAll();
//     print('found ${consumptions.length} consumptions');

//     for (var i = 0; i < consumptions.length; i++) {
//       print('consumption $i of ${consumptions.length}');

//       var consumption = consumptions[i];

//       print('  creating ${consumption.reference!.id}...');

//       await privateConsumptionsCollection.create(
//         consumption,
//         consumption.reference!.id,
//       );

//       print('  OK');
//     }
//   }
// }
