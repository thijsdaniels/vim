import 'package:vim/models/exercise/set.dart';

extension Sets on List<Set> {
  static List<Set> fromMap(Iterable<dynamic> list) {
    return list.map((map) => Set.fromMap(map)).toList();
  }

  static List<Set> fromRecords(
    Iterable<SetRecord> records,
  ) {
    return records.map((record) => Set.fromRecord(record)).toList();
  }

  List<Map<String, dynamic>> toMap() {
    return map((set) => set.toMap()).toList();
  }

  num get repetitions {
    return map((set) => set.repetitions)
        .reduce((total, repetitions) => total + repetitions);
  }

  num get weight {
    return map((set) => set.weight).reduce((total, weight) => total + weight);
  }
}
