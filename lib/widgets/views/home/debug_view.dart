import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/exercise/exercise.dart';
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

class Migrate extends StatelessWidget {
  const Migrate({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: migrate(),
      builder: (context, snapshot) {
        return snapshot.hasData
            ? SelectableText(
                snapshot.data!.join("\n"),
              )
            : const CircularProgressIndicator();
      },
    );
  }

  Future<Iterable<String>> migrate() async {
    var exercisesCollection =
        FirebaseFirestore.instance.collection('exercises');

    var performancesCollectionGroup =
        FirebaseFirestore.instance.collectionGroup('performances');

    var exercises = (await exercisesCollection.get()).docs;

    var performances = (await performancesCollectionGroup
            // .where('exercise.name', isNull: false)
            .get())
        .docs;

    return performances
        .where((performance) => performance.data()['exercise']?['name'] != null)
        .toList()
        // .sublist(0, 2)
        .map(
      (performanceDoc) {
        var newName = newExerciseName(performanceDoc.get('exercise.name'));

        var exerciseDoc = exercises.firstWhere(
          (exercise) => exercise.get('name') == newName,
          orElse: () =>
              throw Exception('Exercise not found for name "$newName".'),
        );

        switch (performanceDoc.get('exercise.type')) {
          case "weights":
            performanceDoc.reference.set({
              'timestamp': performanceDoc.get('timestamp'),
              'exercise':
                  Exercise.fromSnapshot(exerciseDoc).toSnapshot().toMap(),
              'sets': performanceDoc.get('sets'),
            });
          case "resistance":
            performanceDoc.reference.set({
              'timestamp': performanceDoc.get('timestamp'),
              'exercise':
                  Exercise.fromSnapshot(exerciseDoc).toSnapshot().toMap(),
              'duration': performanceDoc.get('duration'),
              'watts': performanceDoc.get('watts'),
            });
        }

        return performanceDoc.reference.path;
      },
    );
  }

  String newExerciseName(String name) {
    var newName = {
      // old names
      "Abdominal Crunch": "Abdominal Crunch, Machine",
      "Arm Curl": "Bicep Curl, Machine",
      "Arnold Press": "Arnold Press, Dumbbells",
      "Back Extension": "Back Extension, Machine",
      "Back Squat": "Squat, Barbell",
      "Cable Chest Press": "Chest Press, Cable",
      "Cable Row": "Seated Row, Cable",
      "Calf Raise": "Calf Raise, Dumbbells",
      "Chest Press": "Chest Press, Machine",
      "Chest-Supported Row": "Isolated Row, Machine",
      "Decline Bench Press": "Decline Bench Press, Barbell",
      "Dumbbell Curl": "Bicep Curl, Dumbbells",
      "Dumbbell Fly": "Fly, Dumbbells",
      "Dumbbell Lateral Raise": "Lateral Raise, Dumbbells",
      "Dumbbell Press": "Bench Press, Dumbbells",
      "Dumbbell Reverse Fly": "Reverse Fly, Dumbbells",
      "Dumbbell Romanian Deadlift": "Romanian Deadlift, Dumbbells",
      "Dumbbell Row": "Row, Dumbbells",
      "Dumbbell Skull Crushers": "Skull Crushers, Dumbbells",
      "Dumbbell Squat": "Squat, Dumbbells",
      "French Press": "Skull Crushers, Dumbbells",
      "Goblet Squat": "Goblet Squat, Dumbbell",
      "Incline Bench Press": "Incline Bench Press, Barbell",
      "Incline Dumbbell Curl": "Seated Bicep Curl, Dumbbells",
      "Incline Dumbbell Press": "Incline Bench Press, Dumbbells",
      "Inclined Bench Press": "Incline Bench Press, Barbell",
      "Inclined Dumbbell Press": "Incline Bench Press, Dumbbells",
      "Landmine Overhead Press": "Overhead Press, Landmine",
      "Landmine Press": "Overhead Press, Landmine",
      "Lat Pulldown": "Lat Pulldown, Machine",
      "Lat Raise": "Lateral Raise, Dumbbells",
      "Lateral Raise": "Lateral Raise, Dumbbells",
      "Leg Curl": "Leg Curl, Machine",
      "Leg Extension": "Leg Extension, Machine",
      "Leg Press": "Leg Press, Machine",
      "Preacher Curl": "Preacher Curl, Dumbbells",
      "Preacher Curls": "Preacher Curl, Dumbbells",
      "Reverse Fly": "Reverse Fly, Dumbbells",
      "Romanian Deadlift": "Romanian Deadlift, Barbell",
      "Rotary Torso": "Rotary Torso, Machine",
      "Seated Dumbbell Curl": "Seated Bicep Curl, Dumbbells",
      "Seated Row": "Isolated Row, Machine",
      "Shoulder Press": "Shoulder Press, Machine",
      "Squat": "Squat, Barbell",
      "Row, Dumbbell": "Row, Dumbbells",
      "Dumbbell Calf Raise": "Calf Raise, Dumbbells",

      // new names
      "Abdominal Crunch, Machine": "Abdominal Crunch, Machine",
      "Back Extension, Machine": "Back Extension, Machine",
      "Bench Press, Dumbbells": "Bench Press, Dumbbells",
      "Bicep Curl, Machine": "Bicep Curl, Machine",
      "Calf Raise, Dumbbells": "Calf Raise, Dumbbells",
      "Calf Raise, Machine": "Calf Raise, Machine",
      "Chest Press, Cable": "Chest Press, Cable",
      "Chest Press, Machine": "Chest Press, Machine",
      "Dead Bug": "Dead Bug",
      "Elliptical": "Elliptical",
      "Fly, Dumbbells": "Fly, Dumbbells",
      "Incline Bench Press, Dumbbells": "Incline Bench Press, Dumbbells",
      "Isolated Row, Machine": "Isolated Row, Machine",
      "Lat Pulldown, Machine": "Lat Pulldown, Machine",
      "Lateral Raise, Dumbbells": "Lateral Raise, Dumbbells",
      "Lateral Raise, Machine": "Lateral Raise, Machine",
      "Leg Curl, Machine": "Leg Curl, Machine",
      "Leg Press, Machine": "Leg Press, Machine",
      "Reverse Fly, Cable": "Reverse Fly, Cable",
      "Reverse Fly, Dumbbells": "Reverse Fly, Dumbbells",
      "Romanian Deadlift, Barbell": "Romanian Deadlift, Barbell",
      "Romanian Deadlift, Dumbbells": "Romanian Deadlift, Dumbbells",
      "Rotary Torso, Machine": "Rotary Torso, Machine",
      "Row, Dumbbells": "Row, Dumbbells",
      "Seated Bicep Curl, Dumbbells": "Seated Bicep Curl, Dumbbells",
      "Seated Row, Cable": "Seated Row, Cable",
      "Shoulder Press, Machine": "Shoulder Press, Machine",
      "Skull Crushers, Dumbbells": "Skull Crushers, Dumbbells",
      "Squat, Barbell": "Squat, Barbell",
      "Squat, Dumbbells": "Squat, Dumbbells",
    }[name];

    if (newName == null) {
      throw Exception('Failed to find new name for "$name".');
    }

    return newName;
  }
}
