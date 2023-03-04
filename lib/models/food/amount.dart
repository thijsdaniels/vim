import 'package:flutter/foundation.dart';
import 'package:vim/models/model.dart';

enum Unit {
  grams,
  servings,
}

class Amount extends Model {
  final Unit unit;
  final num value;

  Amount({
    required this.unit,
    required this.value,
  });

  @override
  String toString() {
    return '$value ${describeEnum(unit)}';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'unit': describeEnum(unit),
      'value': value,
    };
  }

  static Amount fromMap(Map<String, dynamic> map) {
    return Amount(
      unit: Unit.values.firstWhere(
        (unit) => describeEnum(unit) == map['unit'],
      ),
      value: map['value'],
    );
  }

  factory Amount.grams(num value) {
    return Amount(unit: Unit.grams, value: value);
  }

  factory Amount.servings(num value) {
    return Amount(unit: Unit.servings, value: value);
  }
}
