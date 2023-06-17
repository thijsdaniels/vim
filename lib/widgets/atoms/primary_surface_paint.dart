import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class PrimarySurfacePaint extends StatelessWidget {
  const PrimarySurfacePaint({
    super.key,
    this.color,
    this.child,
  });

  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Consumer<FragmentProgram?>(
      builder: (context, fragmentProgram, _) => fragmentProgram != null
          ? _PrimarySurfacePaint(
              shader: fragmentProgram.fragmentShader(),
              color: color ?? Theme.of(context).colorScheme.primaryContainer,
              child: child,
            )
          : Container(child: child),
    );
  }
}

class _PrimarySurfacePaint extends StatefulWidget {
  const _PrimarySurfacePaint({
    required this.shader,
    required this.color,
    this.child,
  });

  final FragmentShader shader;
  final Color color;
  final Widget? child;

  @override
  State<_PrimarySurfacePaint> createState() => _PrimarySurfacePaintState();
}

class _PrimarySurfacePaintState extends State<_PrimarySurfacePaint> {
  late final Ticker _ticker;
  Duration _time = Duration.zero;

  @override
  void initState() {
    _ticker = Ticker(_onTick);
    _ticker.start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.stop();
    _ticker.dispose();
    super.dispose();
  }

  void _onTick(Duration time) {
    setState(() {
      _time = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    var box = (context.findRenderObject() as RenderBox?);
    var offset = box?.localToGlobal(Offset.zero) ?? Offset.zero;

    return CustomPaint(
      painter: _PrimarySurfacePainter(
        shader: widget.shader,
        time: _time,
        offset: offset,
        size: MediaQuery.of(context).size,
        color: widget.color,
      ),
      child: widget.child,
    );
  }
}

class _PrimarySurfacePainter extends CustomPainter {
  _PrimarySurfacePainter({
    required this.shader,
    required this.time,
    required this.offset,
    required this.size,
    required this.color,
  });

  final FragmentShader shader;
  final Duration time;
  final Offset offset;
  final Size size;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // uTime
    // shader.setFloat(0, (DateTime.now().millisecondsSinceEpoch / 1000));

    // uOrigin
    shader.setFloat(0, offset.dx);
    shader.setFloat(1, offset.dy);

    // uSize
    shader.setFloat(2, this.size.width);
    shader.setFloat(3, this.size.height);

    // uColor
    shader.setFloat(4, color.red / 255);
    shader.setFloat(5, color.green / 255);
    shader.setFloat(6, color.blue / 255);
    shader.setFloat(7, color.alpha / 255);

    // uSpread
    shader.setFloat(8, 45);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
