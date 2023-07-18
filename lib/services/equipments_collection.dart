import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/equipment.dart';
import 'package:vim/services/collection.dart';

class EquipmentsCollection extends Collection<Equipment> {
  static EquipmentsCollection of(BuildContext context) {
    return Provider.of<EquipmentsCollection>(context, listen: false);
  }

  EquipmentsCollection({required super.path});

  @override
  Equipment fromFirestore(snapshot, options) {
    return Equipment.fromFirestore(snapshot, options);
  }

  @override
  Stream<List<Equipment>> all() {
    return collection
        .orderBy('name')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
