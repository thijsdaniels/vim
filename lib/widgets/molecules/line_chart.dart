import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/surface.dart';

const int millisecondsPerDay = 86400000;

typedef ChartAxis = ({
  num min,
  num max,
  num interval,
});

class LineChart extends StatefulWidget {
  const LineChart({
    super.key,
    this.elevation,
    required this.series,
    this.xAxis,
    this.yAxis,
  });

  final double? elevation;
  final List<Map<DateTime, num>> series;
  final ChartAxis? xAxis;
  final ChartAxis? yAxis;

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  late num xMin;
  late num xMax;
  late num yMin;
  late num yMax;

  List<DateTime> get dates =>
      widget.series.map((serie) => serie.keys).flattened.toList();

  List<num> get values =>
      widget.series.map((serie) => serie.values).flattened.toList();

  DateTime get minDate => dates.min;
  DateTime get maxDate => dates.max;
  int get dateRange =>
      maxDate.millisecondsSinceEpoch - minDate.millisecondsSinceEpoch;

  num get minValue => values.min;
  num get maxValue => values.max;
  num get valueRange => maxValue - minValue;

  @override
  void initState() {
    super.initState();

    xMin = widget.xAxis?.min ??
        minDate
            .subtract(Duration(milliseconds: dateRange ~/ 10))
            .millisecondsSinceEpoch;

    xMax = widget.xAxis?.max ??
        maxDate
            .add(Duration(milliseconds: dateRange ~/ 10))
            .millisecondsSinceEpoch;

    yMin = widget.yAxis?.min ?? (minValue - (valueRange) / 10);
    yMax = widget.yAxis?.max ?? (maxValue + (valueRange) / 10);
  }

  @override
  Widget build(BuildContext context) {
    double xAxisHeight = 28;
    double yAxisWidth = 40;
    double spacing = 8;

    ChartAxis xAxis = (
      min: xMin,
      max: xMax,
      interval: widget.xAxis?.interval ??
          millisecondsPerDay * (dateRange / millisecondsPerDay / 10).round(),
    );

    ChartAxis yAxis = (
      min: yMin,
      max: yMax,
      interval: widget.yAxis?.interval ?? valueRange / 6,
    );

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Surface(
                  elevation: widget.elevation,
                  child: CustomPaint(
                    size: Size.fromWidth(yAxisWidth),
                    painter: YAxisPainter(yAxis: yAxis),
                  ),
                ),
                SizedBox(width: spacing),
                Expanded(
                  child: Surface(
                    isPrimary: true,
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: XGridPainter(xAxis: xAxis),
                          child: Container(),
                        ),
                        CustomPaint(
                          painter: YGridPainter(yAxis: yAxis),
                          child: Container(),
                        ),
                        ...widget.series.map(
                          (serie) => CustomPaint(
                            painter: LineSeriesPainter(
                              data: serie,
                              xAxis: xAxis,
                              yAxis: yAxis,
                            ),
                            child: Container(),
                          ),
                        ),
                        GestureDetector(
                          onPanUpdate: (details) {
                            setState(() {
                              xMin += details.delta.dx * -18000000;
                              xMax += details.delta.dx * -18000000;
                              yMin += details.delta.dy * 0.3;
                              yMax += details.delta.dy * 0.3;
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: spacing),
          Row(
            children: [
              SizedBox(width: yAxisWidth),
              SizedBox(width: spacing),
              Expanded(
                child: Surface(
                  elevation: widget.elevation,
                  child: CustomPaint(
                    size: Size.fromHeight(xAxisHeight),
                    painter: XAxisPainter(xAxis: xAxis),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

mixin XAxis {
  ChartAxis get xAxis;

  double xToPixel(num x, Size size) {
    const left = 0.0;
    final right = size.width;

    final spacing = (right - left) / (xAxis.max - xAxis.min);

    return left + (x - xAxis.min) * spacing;
  }
}

mixin YAxis {
  ChartAxis get yAxis;

  double yToPixel(num y, Size size) {
    const top = 0.0;
    final bottom = size.height;

    final spacing = (bottom - top) / (yAxis.max - yAxis.min);

    return bottom - (y - yAxis.min) * spacing;
  }
}

abstract class AxisPainter extends CustomPainter {
  final double labelSize = 12;
  final double axisSpacing = 8;

  final labelColor = Colors.white;

  final axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white.withOpacity(0.5)
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    paintLabels(canvas, size);
  }

  void paintLabels(Canvas canvas, Size size);
}

class XAxisPainter extends AxisPainter with XAxis {
  XAxisPainter({
    required this.xAxis,
  });

  @override
  final ChartAxis xAxis;

  @override
  void paintLabels(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = -1; i < (xAxis.max - xAxis.min) / xAxis.interval + 1; i++) {
      var label = xAxis.min +
          (xAxis.interval - (xAxis.min % xAxis.interval)) +
          xAxis.interval * i;

      final textSpan = TextSpan(
        text: DateTime.fromMillisecondsSinceEpoch(label.toInt())
            .toLocal()
            .day
            .toString(),
        style: TextStyle(
          color: labelColor,
          fontSize: labelSize,
        ),
      );

      textPainter.text = textSpan;
      textPainter.layout();

      final textX = xToPixel(label, size) - textPainter.width / 2;
      final textY = size.height - textPainter.height - axisSpacing;

      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !const DeepCollectionEquality().equals(
      (oldDelegate as XAxisPainter).xAxis,
      xAxis,
    );
  }
}

class YAxisPainter extends AxisPainter with YAxis {
  YAxisPainter({
    required this.yAxis,
  });

  @override
  final ChartAxis yAxis;

  @override
  void paintLabels(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = -1; i < (yAxis.max - yAxis.min) / yAxis.interval + 1; i++) {
      var label = yAxis.min +
          (yAxis.interval - (yAxis.min % yAxis.interval)) +
          yAxis.interval * i;

      final textSpan = TextSpan(
        text: label.toInt().toString(),
        style: TextStyle(
          color: labelColor,
          fontSize: labelSize,
        ),
      );

      textPainter.text = textSpan;
      textPainter.layout();

      final textX = size.width - axisSpacing - textPainter.width;
      final textY = yToPixel(label, size) - textPainter.height / 2;

      textPainter.paint(canvas, Offset(textX, textY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !const DeepCollectionEquality().equals(
      (oldDelegate as YAxisPainter).yAxis,
      yAxis,
    );
  }
}

class XGridPainter extends CustomPainter with XAxis {
  XGridPainter({
    required this.xAxis,
  });

  @override
  final ChartAxis xAxis;

  final gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white.withOpacity(0.15)
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    for (int i = 0; i < (xAxis.max - xAxis.min) / xAxis.interval; i++) {
      var x = xToPixel(
        xAxis.min +
            (xAxis.interval - (xAxis.min % xAxis.interval)) +
            xAxis.interval * i,
        size,
      );

      path.moveTo(x, 0.0);
      path.lineTo(x, size.height);
    }

    canvas.drawPath(path, gridPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !const DeepCollectionEquality().equals(
      (oldDelegate as XGridPainter).xAxis,
      xAxis,
    );
  }
}

class YGridPainter extends CustomPainter with YAxis {
  YGridPainter({
    required this.yAxis,
  });

  @override
  final ChartAxis yAxis;

  final gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white.withOpacity(0.15)
    ..strokeWidth = 1;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    for (int i = 0; i < (yAxis.max - yAxis.min) / yAxis.interval; i++) {
      var y = yToPixel(
        yAxis.min +
            (yAxis.interval - (yAxis.min % yAxis.interval)) +
            yAxis.interval * i,
        size,
      );

      path.moveTo(0.0, y);
      path.lineTo(size.width, y);
    }

    canvas.drawPath(path, gridPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !const DeepCollectionEquality().equals(
      (oldDelegate as YGridPainter).yAxis,
      yAxis,
    );
  }
}

class LineSeriesPainter extends CustomPainter with XAxis, YAxis {
  LineSeriesPainter({
    required this.data,
    required this.xAxis,
    required this.yAxis,
  });

  @override
  final ChartAxis xAxis;

  @override
  final ChartAxis yAxis;

  final Map<DateTime, num> data;

  final linePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.white
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;

  final dotPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.deepPurple[700]!;

  @override
  void paint(Canvas canvas, Size size) {
    final coordinates = data.entries.map(
      (entry) => Offset(
        xToPixel(entry.key.millisecondsSinceEpoch, size),
        yToPixel(entry.value, size),
      ),
    );

    paintLine(canvas, coordinates);
    paintDots(canvas, coordinates);
  }

  void paintLine(Canvas canvas, Iterable<Offset> coordinates) {
    final path = Path();
    var firstPoint = true;
    for (var coordinate in coordinates) {
      if (firstPoint) {
        firstPoint = false;
        path.moveTo(coordinate.dx, coordinate.dy);
      } else {
        path.lineTo(coordinate.dx, coordinate.dy);
      }
    }

    canvas.drawPath(path, linePaint);
  }

  void paintDots(Canvas canvas, Iterable<Offset> coordinates) {
    for (var coordinate in coordinates) {
      canvas.drawCircle(coordinate, 3, linePaint);
      canvas.drawCircle(coordinate, 2, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return !const DeepCollectionEquality().equals(
      (oldDelegate as LineSeriesPainter).data,
      data,
    );
  }
}
