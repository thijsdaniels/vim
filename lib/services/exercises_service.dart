import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/service.dart';

class ExercisesService extends Service<Exercise> {
  static ExercisesService of(BuildContext context) {
    return Provider.of<ExercisesService>(context, listen: false);
  }

  ExercisesService({required super.path});

  @override
  Exercise fromFirestore(snapshot, options) {
    return Exercise.fromSnapshot(snapshot);
  }

  @override
  Stream<List<Exercise>> all() {
    return collection.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
