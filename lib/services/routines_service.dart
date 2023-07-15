import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/services/service.dart';

class RoutinesService extends Service<Routine> {
  static RoutinesService of(BuildContext context) {
    return Provider.of<RoutinesService>(context, listen: false);
  }

  RoutinesService({required super.path});

  @override
  Routine fromFirestore(snapshot, options) {
    return Routine.fromSnapshot(snapshot);
  }

  @override
  Stream<List<Routine>> all() {
    return collection.orderBy('name').snapshots().map(
          (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
        );
  }
}
