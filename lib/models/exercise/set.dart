import 'package:flutter/material.dart';
import 'package:vim/models/model.dart';

typedef SetRecord = ({
  Key key,
  num? weight,
  num? repetitions,
});

class Set extends Model {
  final num weight;
  final num repetitions;

  const Set({
    required this.weight,
    required this.repetitions,
  });

  static Set fromMap(Map<String, dynamic> map) {
    return Set(
      weight: map['weight'],
      repetitions: map['repetitions'],
    );
  }

  static Set fromRecord(SetRecord record) {
    return Set(
      weight: record.weight ?? 0,
      repetitions: record.repetitions ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'repetitions': repetitions,
    };
  }
}

/// TODO: This class is currently not used, but I kinda like the idea of using
/// input classes that validate their requirements when they get turned into
/// models. I'm keeping this in case I want to refactor to it later.
// class SetInput extends Model {
//   num? repetitions;
//   num? weight;
//
//   SetInput({
//     this.repetitions,
//     this.weight,
//   });
//
//   factory SetInput.fromModel(Set set) {
//     return SetInput(
//       repetitions: set.repetitions,
//       weight: set.weight,
//     );
//   }
//
//   Set toModel() {
//     assert(repetitions != null && weight != null);
//
//     return Set(
//       repetitions: repetitions!,
//       weight: weight!,
//     );
//   }
//
//   @override
//   Map<String, dynamic> toMap() {
//     return {
//       'repetitions': repetitions,
//       'weight': weight,
//     };
//   }
// }
