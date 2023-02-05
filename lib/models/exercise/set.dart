import 'package:vim/models/model.dart';

class Set extends Model {
  num repetitions;
  num weight;

  /// This calculation is derived from the values presented by the MyWellness
  /// app developed by TechnoGym. It is undoubtedly inaccuracte, but it is a
  /// decent starting point if nothing else.
  num get calories => 5 + repetitions * 0.05 * weight * 0.225;

  Set({
    required this.repetitions,
    required this.weight,
  });

  static Set fromMap(Map<String, dynamic> map) {
    return Set(
      repetitions: map['repetitions'],
      weight: map['weight'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'repetitions': repetitions,
      'weight': weight,
    };
  }
}
