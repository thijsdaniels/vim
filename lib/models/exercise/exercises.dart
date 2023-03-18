import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/exercise.dart';

class Exercises extends MutableCollection<Exercise> {
  const Exercises([super.entries = const []]);

  static Exercises fromMap(List<dynamic> list) {
    return Exercises(
      list.map((map) => Exercise.fromMap(map)).toList(),
    );
  }
}
