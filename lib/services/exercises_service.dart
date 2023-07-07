import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/exercise/exercise.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/service.dart';

class ExercisesService extends Service<Exercise> {
  static ExercisesService of(BuildContext context) {
    return Provider.of<ExercisesService>(context, listen: false);
  }

  ExercisesService(User? user)
      : super(
            path: user != null
                ? 'users/${user.reference!.id}/exercises'
                : 'exercises');

  @override
  Exercise fromFirestore(snapshot, options) {
    return Exercise.fromSnapshot(snapshot);
  }
}
