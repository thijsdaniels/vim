import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/surface.dart';

class ListSurface extends StatelessWidget {
  final Widget? icon;
  final Function()? onTap;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final double? elevation;
  final bool dense;

  const ListSurface({
    super.key,
    this.icon,
    this.onTap,
    required this.title,
    this.subtitle,
    this.trailing,
    this.elevation,
    this.dense = false,
  });

  @override
  Widget build(BuildContext context) {
    return Surface(
      elevation: elevation,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Surface(
              emphasis: Emphasis.medium,
              elevation: (elevation ?? 0) + 4,
              child: SizedBox(
                width: dense ? 56 : 72,
                height: dense ? 56 : 72,
                child: Center(child: icon),
              ),
            ),
            Expanded(
              child: ListTile(
                dense: dense,
                title: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: subtitle != null ? SecondaryText(subtitle!) : null,
                trailing: trailing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
