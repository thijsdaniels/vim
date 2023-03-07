import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/set.dart';

class Sets extends Collection<Set> {
  const Sets([super.entries = const []]);

  static Sets fromMap(Iterable<dynamic> list) {
    return Sets(
      list.map((map) => Set.fromMap(map)).toList(),
    );
  }

  num get calories => entries
      .map((set) => set.calories)
      .reduce((total, calories) => total + calories);

  num get repetitions => entries
      .map((set) => set.repetitions ?? 0)
      .reduce((total, repetitions) => total + repetitions);

  num get weight => entries
      .map((set) => set.weight ?? 0)
      .reduce((total, weight) => total + weight);
}

// class SetsInput extends MutableCollection<SetInput> {
//   const SetsInput([super.entries = const []]);

//   toModel() {
//     return Sets(
//       entries
//           .where(
//             (input) => input.weight != null && input.repetitions != null,
//           )
//           .map(
//             (input) => Set(
//               weight: input.weight!,
//               repetitions: input.repetitions!,
//             ),
//           )
//           .toList(),
//     );
//   }

//   static fromModel(Sets model) {
//     return SetsInput(
//       model.entries
//           .map(
//             (set) => SetInput(
//               repetitions: set.repetitions,
//               weight: set.weight,
//             ),
//           )
//           .toList(),
//     );
//   }
// }
