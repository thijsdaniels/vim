import 'dart:async';

import 'package:vim/models/exercise/performance.dart';

class QuickPerformance extends Performance {
  @override
  String name;

  @override
  FutureOr<num> calories;

  QuickPerformance({
    required super.timestamp,
    required this.name,
    required this.calories,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'name': name,
      'calories': calories,
    };
  }

  static QuickPerformance fromMap(Map<String, dynamic> map) {
    return QuickPerformance(
      timestamp: map['timestamp'],
      name: map['name'],
      calories: map['calories'],
    );
  }
}
