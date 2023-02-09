import 'package:vim/models/model.dart';

class Set extends Model {
  num? repetitions;
  num? weight;

  /// This calculation is derived from the values presented by the MyWellness
  /// app developed by TechnoGym. It is undoubtedly inaccuracte, but it is a
  /// decent starting point if nothing else.
  num get calories => repetitions != null && weight != null
      ? 5 + repetitions! * 0.05 * weight! * 0.225
      : 0;

  Set({
    this.repetitions,
    this.weight,
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

/**
 * @todo This class is currently now used, but I kinda like the idea of using
 * input classes that validate their requirements when they get turned into
 * models. I'm keeping this in case I want to refactor to it later.
 */
class SetInput {
  num? repetitions;
  num? weight;

  SetInput({
    this.repetitions,
    this.weight,
  });

  factory SetInput.fromModel(Set set) {
    return SetInput(
      repetitions: set.repetitions,
      weight: set.weight,
    );
  }

  Set toModel() {
    assert(repetitions != null && weight != null);

    return Set(
      repetitions: repetitions!,
      weight: weight!,
    );
  }
}
