import 'package:flutter/foundation.dart';

enum Unit {
  grams,
  servings,
}

class Amount {
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

  factory Amount.grams({required num value}) {
    return Amount(unit: Unit.grams, value: value);
  }

  factory Amount.servings({required num value}) {
    return Amount(unit: Unit.servings, value: value);
  }
}
