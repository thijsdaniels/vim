import 'package:vim/models/collection.dart';
import 'package:vim/models/exercise/routine.dart';

class Routines extends Collection<Routine> {
  const Routines([super.entries = const []]);

  static Routines fromMap(Iterable<Map<String, dynamic>> map) {
    return Routines(
      map.map((map) => Routine.fromMap(map)).toList(),
    );
  }
}
