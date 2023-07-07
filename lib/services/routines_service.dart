import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/routine.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class RoutinesService extends Service<Routine> {
  static RoutinesService of(BuildContext context) {
    return Provider.of<RoutinesService>(context, listen: false);
  }

  RoutinesService(User? user)
      : super(
            path: user != null
                ? 'users/${user.reference!.id}/routines'
                : 'routines');

  @override
  Routine fromFirestore(snapshot, options) {
    return Routine.fromSnapshot(snapshot);
  }
}
