import 'dart:math';

extension RoundExtension on double {
  double decimals(double precision) {
    num factor = pow(10, precision);

    return (this * factor).round() / factor;
  }
}
