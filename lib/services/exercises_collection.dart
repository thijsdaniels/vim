import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/services/collection.dart';

class ExercisesCollection extends Collection<Exercise> {
  static ExercisesCollection of(BuildContext context) {
    return Provider.of<ExercisesCollection>(context, listen: false);
  }

  ExercisesCollection({required super.path});

  @override
  Exercise fromFirestore(snapshot, options) {
    return Exercise.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Exercise>> all() {
    return collection
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
