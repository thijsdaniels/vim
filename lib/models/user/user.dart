import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/extensions/performances.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/user/body.dart';
import 'package:vim/models/user/target.dart';

/// TODO: Rename to `UserProfile` or even just `Profile`?
/// TODO: Add the various user-scoped subcollections to this class.
class User extends Document {
  Body body;
  Target target;
  double neat;

  double get _unadjustedTargetConsumption =>
      (body.bmr + neat) * (1 + target.consumption.surplus);

  // TODO: Shouldn't I divide by `targetConsumption(performances)`?
  double get targetProteinConsumption =>
      Proteins.calories(target.consumption.proteins * body.weight) /
      _unadjustedTargetConsumption;

  double get targetCarbohydrateConsumption =>
      1 - target.consumption.fats - targetProteinConsumption;

  double get targetFatConsumption => target.consumption.fats;

  User({
    required this.body,
    required this.target,
    required this.neat,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    return User.fromMap(snapshot.data()!)
      ..reference = snapshot.reference.withConverter<User>(
        fromFirestore: User.fromFirestore,
        toFirestore: (exercise, _) => exercise.toMap(),
      );
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      body: Body.fromMap(map['body']),
      target: Target.fromMap(map['target']),
      neat: map['neat'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'body': body.toMap(),
      'target': target.toMap(),
      'neat': neat,
    };
  }

  Future<double> targetConsumption(List<Performance> performances) async {
    return target.performance.adjustTargetConsumption
        ? _unadjustedTargetConsumption + await performances.calories
        : _unadjustedTargetConsumption;
  }
}
