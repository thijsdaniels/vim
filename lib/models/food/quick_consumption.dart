import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/nutrition.dart';

class QuickConsumption extends Consumption {
  @override
  String name;
  @override
  Nutrition nutrition;

  QuickConsumption({
    required super.timestamp,
    required this.name,
    required this.nutrition,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp,
      'name': name,
      'nutrition': nutrition.toMap(),
    };
  }

  static QuickConsumption fromMap(Map<String, dynamic> map) {
    return QuickConsumption(
      timestamp: map['timestamp'],
      name: map['name'],
      nutrition: Nutrition.fromMap(map['nutrition']),
    );
  }
}
