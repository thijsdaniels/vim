import 'package:vim/models/model.dart';

class Mass extends Model {
  static const gramsPerMilligram = 0.001;
  static const gramsPerKilogram = 1000;
  static const gramsPerPound = 453.592;

  final num grams;

  const Mass.grams(this.grams);

  const Mass.milligrams(num milligrams)
      : grams = milligrams * gramsPerMilligram;

  const Mass.kilograms(num kilograms) : grams = kilograms * gramsPerKilogram;

  const Mass.pounds(num pounds) : grams = pounds * gramsPerPound;

  num get milligrams => grams / gramsPerMilligram;
  num get kilograms => grams / gramsPerKilogram;
  num get pounds => grams / gramsPerPound;

  @override
  Map<String, dynamic> toMap() {
    return {
      'grams': grams,
    };
  }

  static Mass fromMap(Map<String, dynamic> map) {
    return Mass.grams(map['grams']);
  }
}
