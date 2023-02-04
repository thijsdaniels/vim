class Energy {
  static double caloriesPerJoule = 0.238902957619;
  static double joulesPerCalorie = 1 / caloriesPerJoule;

  num _joules;

  num get joules => _joules;
  num get calories => joules * caloriesPerJoule;
  num get kiloCalories => calories / 1000;

  Energy(this._joules);

  factory Energy.joules(num joules) {
    return Energy(joules);
  }

  factory Energy.calories(num calories) {
    return Energy.joules(calories * joulesPerCalorie);
  }

  factory Energy.kiloCalories(num kiloCalories) {
    return Energy.calories(kiloCalories * 1000);
  }

  factory Energy.watts(num watts, Duration duration) {
    return Energy.joules(watts * duration.inSeconds);
  }

  Energy operator +(Energy other) {
    return Energy(joules + other.joules);
  }

  Energy operator -(Energy other) {
    return Energy(joules - other.joules);
  }

  Energy operator *(num factor) {
    return Energy(joules * factor);
  }

  Energy operator /(num factor) {
    return Energy(joules / factor);
  }
}
