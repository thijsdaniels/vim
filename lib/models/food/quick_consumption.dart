import 'package:vim/models/food/consumption.dart';
import 'package:vim/models/food/nutrition.dart';

class QuickConsumption extends Consumption {
  @override
  String name;
  @override
  Nutrition nutrition;

  QuickConsumption({
    required super.user,
    required super.timestamp,
    required this.name,
    required this.nutrition,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'name': name,
      'nutrition': nutrition.toMap(),
    };
  }

  static QuickConsumption fromMap(Map<String, dynamic> map) {
    return QuickConsumption(
      user: map['user'],
      timestamp: map['timestamp'],
      name: map['name'],
      nutrition: Nutrition.fromMap(map['nutrition']),
    );
  }
}
