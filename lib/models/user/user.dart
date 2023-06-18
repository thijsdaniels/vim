import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/extensions/performances_list.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/user/body.dart';
import 'package:vim/models/user/target.dart';

class User extends Document {
  User({
    required this.body,
    required this.target,
    required this.neat,
  });

  DocumentReference? _reference;

  Body body;
  Target target;
  double neat;

  @override
  DocumentReference? get reference => _reference;

  double get _unadjustedTargetConsumption =>
      (body.bmr + neat) * (1 + target.consumption.surplus);

  Future<double> targetConsumption(List<Performance> performances) async {
    return target.performance.adjustTargetConsumption
        ? _unadjustedTargetConsumption + await performances.calories
        : _unadjustedTargetConsumption;
  }

  // TODO: Shouldn't I divide by `targetConsumption(performances)`?
  double get targetProteinConsumption =>
      Proteins.calories(target.consumption.proteins * body.weight) /
      _unadjustedTargetConsumption;

  double get targetCarbohydrateConsumption =>
      1 - target.consumption.fats - targetProteinConsumption;

  double get targetFatConsumption => target.consumption.fats;

  static User fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    Map<String, dynamic> map = snapshot.data()!;

    User user = fromMap(map);
    user._reference = snapshot.reference;

    return user;
  }

  static User fromMap(Map<String, dynamic> map) {
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
}
