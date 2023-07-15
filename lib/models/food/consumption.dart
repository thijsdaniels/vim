import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vim/models/document.dart';
import 'package:vim/models/food/nutrition.dart';

abstract class Consumption extends Document {
  Timestamp timestamp;

  String get name;
  FutureOr<Nutrition> get nutrition;

  Consumption({
    required this.timestamp,
  });
}
