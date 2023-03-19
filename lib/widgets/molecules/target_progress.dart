import 'package:flutter/material.dart';

enum TargetProgressBarSize {
  small,
  large,
}

class TargetProgress extends StatelessWidget {
  const TargetProgress({
    super.key,
    required this.title,
    required this.target,
    required this.progress,
    this.barSize = TargetProgressBarSize.small,
  });

  final String title;
  final num target;
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
            Text(
              ' / ${target.round().toString()}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: barSize == TargetProgressBarSize.small ? 80 : 128,
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(barSize == TargetProgressBarSize.small ? 3 : 4),
            ),
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              tween: Tween<double>(
                begin: 0,
                end: progress / target,
              ),
              builder: (context, value, _) => LinearProgressIndicator(
                value: value,
                minHeight: barSize == TargetProgressBarSize.small ? 6 : 8,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(title),
      ],
    );
  }
}
