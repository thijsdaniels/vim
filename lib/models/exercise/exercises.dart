import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/exercise.dart';

class Exercises extends Collection<Exercise> {
  Exercises([super.entries = const []]);

  static Exercises fromMap(Map<String, dynamic> map) {
    return Exercises(
      map['exercises'].map((map) => Exercise.fromMap(map)),
    );
  }
}
