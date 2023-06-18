import 'package:vim/models/model.dart';

class Target extends Model {
  final ConsumptionTarget consumption;
  final PerformanceTarget performance;

  Target({
    required this.consumption,
    required this.performance,
  });

  static Target fromMap(Map<String, dynamic> map) {
    return Target(
      consumption: ConsumptionTarget.fromMap(map['consumption']),
      performance: PerformanceTarget.fromMap(map['performance']),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'consumption': consumption.toMap(),
      'performance': performance.toMap(),
    };
  }
}

class ConsumptionTarget extends Model {
  double surplus;
  double proteins;
  double fats;

  ConsumptionTarget({
    required this.surplus,
    required this.proteins,
    required this.fats,
  });

  static ConsumptionTarget fromMap(Map<String, dynamic> map) {
    return ConsumptionTarget(
      surplus: map['surplus'],
      proteins: map['proteins'],
      fats: map['fats'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'surplus': surplus,
      'proteins': proteins,
      'fats': fats,
    };
  }
}

class PerformanceTarget extends Model {
  int calories;
  bool adjustTargetConsumption;

  PerformanceTarget({
    required this.calories,
    required this.adjustTargetConsumption,
  });

  static PerformanceTarget fromMap(Map<String, dynamic> map) {
    return PerformanceTarget(
      calories: map['calories'],
      adjustTargetConsumption: map['adjustTargetConsumption'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'calories': calories,
      'adjustTargetConsumption': adjustTargetConsumption,
    };
  }
}
