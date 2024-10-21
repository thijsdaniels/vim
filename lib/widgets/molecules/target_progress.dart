import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/surface.dart';

enum TargetProgressBarSize {
  small,
  large,
}

class TargetProgress extends StatelessWidget {
  const TargetProgress({
    super.key,
    required this.title,
    this.target,
    required this.progress,
    this.barSize = TargetProgressBarSize.small,
  });

  final String title;
  final num? target;
  final num progress;
  final TargetProgressBarSize barSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              progress.round().toString(),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            if (target != null)
              Text(
                ' / ${target!.round().toString()}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: barSize == TargetProgressBarSize.small ? 80 : 128,
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            tween: Tween<double>(
              begin: 0,
              end: target != null ? progress / target! : 0,
            ),
            builder: (context, value, _) => LinearProgressIndicator(
              value: value,
              size: barSize,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }
}

class LinearProgressIndicator extends StatelessWidget {
  final double value;
  final TargetProgressBarSize size;

  const LinearProgressIndicator({
    super.key,
    required this.value,
    this.size = TargetProgressBarSize.small,
  });

  @override
  Widget build(BuildContext context) {
    return Surface(
      emphasis: Emphasis.high,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: SizedBox(
          height: size == TargetProgressBarSize.small ? 6 : 8,
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: max(0, min(1, value)),
            child: const Surface(
              isPrimary: true,
            ),
          ),
        ),
      ),
    );
  }
}
