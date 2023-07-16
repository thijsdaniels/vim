import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/collection.dart';

class RoutinesCollection extends Collection<Routine> {
  static RoutinesCollection of(BuildContext context) {
    return Provider.of<RoutinesCollection>(context, listen: false);
  }

  RoutinesCollection({required super.path});

  @override
  Routine fromFirestore(snapshot, options) {
    return Routine.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Routine>> all() {
    return collection
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
