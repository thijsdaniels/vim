import 'package:vim/models/model.dart';

class Distance extends Model {
  static const metersPerCentimeter = 0.01;
  static const metersPerKilometer = 1000;

  final num meters;

  const Distance.meters(this.meters);

  const Distance.centimeters(num centimeters)
      : meters = centimeters * metersPerCentimeter;

  const Distance.kilometers(num kilometers)
      : meters = kilometers * metersPerKilometer;

  num get centimeters => meters / metersPerCentimeter;
  num get kilometers => meters / metersPerKilometer;

  @override
  Map<String, dynamic> toMap() {
    return {
      'meters': meters,
    };
  }

  static Distance fromMap(Map<String, dynamic> map) {
    return Distance.meters(map['meters']);
  }

  Distance operator -(Distance other) {
    return Distance.meters(meters - other.meters);
  }

  Distance operator +(Distance other) {
    return Distance.meters(meters + other.meters);
  }

  Distance operator *(num factor) {
    return Distance.meters(meters * factor);
  }

  Distance operator /(num factor) {
    return Distance.meters(meters / factor);
  }

  bool operator <(Distance other) {
    return meters < other.meters;
  }

  bool operator <=(Distance other) {
    return meters <= other.meters;
  }

  bool operator >(Distance other) {
    return meters > other.meters;
  }

  bool operator >=(Distance other) {
    return meters >= other.meters;
  }
}
