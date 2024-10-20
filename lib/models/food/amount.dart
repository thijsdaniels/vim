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
    return '$value ${unit.name}';
  }

  Map<String, dynamic> toMap() {
    return {
      'unit': unit.name,
      'value': value,
    };
  }

  static Amount fromMap(Map<String, dynamic> map) {
    return Amount(
      unit: Unit.values.firstWhere(
        (unit) => unit.name == map['unit'],
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
