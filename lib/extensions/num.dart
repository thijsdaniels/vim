import 'dart:math';

extension RoundExtension on num {
  num decimals(num precision) {
    num factor = pow(10, precision);

    return (this * factor).round() / factor;
  }
}
