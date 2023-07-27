import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/performances.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/exercise/performance.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/user/body.dart';
import 'package:vim/models/user/target.dart';

/// TODO: Rename to `UserProfile` or even just `Profile`?
/// TODO: Add the various user-scoped subcollections to this class.
class User extends Document {
  final bool isAdmin;
  String? name;
  Body body;
  Target target;
  num neat;
  List<DocumentReference> following;

  double get targetConsumption =>
      (body.bmr + neat) * (1 + target.consumption.surplus);

  // TODO: Shouldn't I divide by `adjustedTargetConsumption(performances)`?
  double get targetProteinConsumption =>
      Proteins.calories(target.consumption.proteins * body.weight.kilograms) /
      targetConsumption;

  double get targetCarbohydrateConsumption =>
      1 - target.consumption.fats - targetProteinConsumption;

  double get targetFatConsumption => target.consumption.fats;

  String? get initials {
    if (name == null) {
      return null;
    }

    var names = name!.trim().split(' ');

    if (names.length == 1) {
      return names[0][0].toUpperCase();
    } else {
      return names.first[0].toUpperCase() + names.last[0].toUpperCase();
    }
  }

  // TODO: Implement user portraits.
  NetworkImage? get portrait => null;

  User({
    this.isAdmin = false,
    this.name,
    required this.body,
    required this.target,
    required this.neat,
    this.following = const [],
  });

  factory User.of(BuildContext context) {
    return Provider.of<User>(context, listen: false);
  }

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
      isAdmin: map['isAdmin'],
      name: map['name'],
      body: Body.fromMap(map['body']),
      target: Target.fromMap(map['target']),
      neat: map['neat'],
      following: List.castFrom<dynamic, DocumentReference>(map['following']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'isAdmin': isAdmin,
      'name': name,
      'body': body.toMap(),
      'target': target.toMap(),
      'neat': neat,
      'following': following,
    };
  }

  Future<double> adjustedTargetConsumption(
      List<Performance> performances) async {
    return target.performance.adjustTargetConsumption
        ? targetConsumption + await performances.calories
        : targetConsumption;
  }

  void follow(User other) {
    following.add(other.reference!);
    update();
  }

  void unfollow(User other) {
    following.remove(other.reference!);
    update();
  }
}
