import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vim/widgets/molecules/line_chart.dart';

class LineChartComponent {
  static Widget defaultUseCase(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: LineChart(series: _generateSeries()),
    );
  }
}

final Random _generator = Random();

const int _days = 14;

List<Map<DateTime, int>> _generateSeries() {
  List<Map<DateTime, int>> series = [];

  for (int i = 0; i < 2; i++) {
    series.add(_generateData());
  }

  return series;
}

Map<DateTime, int> _generateData() {
  Map<DateTime, int> data = {};

  for (int i = _days - 1; i >= 0; i--) {
    if (Random().nextDouble() < 0.25) continue;

    data[DateTime.now().subtract(Duration(days: i))] =
        300 - 20 * i + _generator.nextInt(200);
  }

  return data;
}
