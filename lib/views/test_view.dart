import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/incremental_number_form_field.dart';
import 'package:vim/widgets/molecules/line_chart.dart';
import 'package:vim/widgets/atoms/standard_list.dart';

class TestView extends StatefulWidget {
  const TestView({super.key});

  @override
  State<TestView> createState() => _IncrementalNumberFormFieldTestViewState();
}

class _IncrementalNumberFormFieldTestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IncrementalNumberFormField(
              decoration: const InputDecoration(
                labelText: 'Uncontrolled',
              ),
              initialValue: 5,
              stepSize: 2.5,
            ),
            const SizedBox(height: 16),
            IncrementalNumberFormField(
              decoration: const InputDecoration(
                labelText: 'Controlled',
              ),
              controller: TextEditingController(text: 5.toString()),
              stepSize: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}

class _LineChartTestViewState extends State<TestView> {
  late List<Map<DateTime, int>> series;
  final Random generator = Random();
  final int days = 14;

  @override
  void initState() {
    super.initState();
    series = generateSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: StandardList(
        children: [
          LineChart(series: series),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => {
                  setState(() {
                    series = generateSeries();
                  })
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Map<DateTime, int>> generateSeries() {
    List<Map<DateTime, int>> series = [];

    for (int i = 0; i < 2; i++) {
      series.add(generateData());
    }

    return series;
  }

  Map<DateTime, int> generateData() {
    Map<DateTime, int> data = {};

    for (int i = days - 1; i >= 0; i--) {
      if (Random().nextDouble() < 0.25) continue;

      data[DateTime.now().subtract(Duration(days: i))] =
          300 - 20 * i + generator.nextInt(200);
    }

    return data;
  }
}
