import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class PrimarySurfaceMask extends StatelessWidget {
  final Widget child;

  const PrimarySurfaceMask({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FragmentProgram?>(
      builder: (context, fragmentProgram, _) => fragmentProgram != null
          ? _ShaderMask(
              shader: fragmentProgram.fragmentShader(),
              child: child,
            )
          : child,
    );
  }
}

/// TODO: Repeats logic defined in the `PrimarySurfacePaint` widget and in the
/// `PrimarySurfacePainter` class.
class _ShaderMask extends StatefulWidget {
  const _ShaderMask({
    required this.shader,
    required this.child,
  });

  final FragmentShader shader;
  final Widget child;

  @override
  State<_ShaderMask> createState() => _ShaderMaskState();
}

class _ShaderMaskState extends State<_ShaderMask> {
  late final Ticker _ticker;
  // ignore: unused_field
  double _time = 0;

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
      _time = DateTime.now().millisecondsSinceEpoch / 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        // uTime
        // widget.shader.setFloat(0, _time);

        // uOrigin
        var box = (context.findRenderObject() as RenderBox?);
        var position = box?.localToGlobal(Offset.zero) ?? Offset.zero;
        widget.shader.setFloat(0, position.dx);
        widget.shader.setFloat(1, position.dy);

        // uSize
        var windowSize = MediaQuery.of(context).size;
        widget.shader.setFloat(2, windowSize.width);
        widget.shader.setFloat(3, windowSize.height);

        // uColor
        var color = Colors.deepPurple[700]!;
        widget.shader.setFloat(4, color.red / 255);
        widget.shader.setFloat(5, color.green / 255);
        widget.shader.setFloat(6, color.blue / 255);
        widget.shader.setFloat(7, color.alpha / 255);

        // uSpread
        widget.shader.setFloat(8, 45);

        return widget.shader;
      },
      child: widget.child,
    );
  }
}
