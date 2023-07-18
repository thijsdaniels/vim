import 'package:vim/models/exercise/equipment.dart';

extension Equipments on List<Equipment> {
  static List<Equipment> fromMap(Iterable<dynamic> list) {
    return list.map((map) => Equipment.fromMap(map)).toList();
  }

  List<Map<String, dynamic>> toMap() {
    return map((equipment) => equipment.toMap()).toList();
  }
}
