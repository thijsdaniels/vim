import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/muscle_map/muscle_map.dart';
import 'package:vim/widgets/atoms/surface.dart';

class DebugView extends StatefulWidget {
  const DebugView({super.key});

  @override
  State<DebugView> createState() => _DebugViewState();
}

class _DebugViewState extends State<DebugView> {
  bool _front = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug'),
      ),
      body: Center(
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
      ),
    );
  }
}
