import 'package:vim/models/model.dart';

class Mass extends Model {
  static const gramsPerMilligram = 0.001;
  static const gramsPerKilogram = 1000;
  static const gramsPerPound = 453.592;

  final double grams;

  const Mass.grams(this.grams);

  const Mass.milligrams(double milligrams)
      : grams = milligrams * gramsPerMilligram;

  const Mass.kilograms(double kilograms) : grams = kilograms * gramsPerKilogram;

  const Mass.pounds(double pounds) : grams = pounds * gramsPerPound;

  double get milligrams => grams / gramsPerMilligram;
  double get kilograms => grams / gramsPerKilogram;
  double get pounds => grams / gramsPerPound;

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
