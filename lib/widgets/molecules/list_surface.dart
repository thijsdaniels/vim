import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/secondary_text.dart';
import 'package:vim/widgets/atoms/surface.dart';

class ListSurface extends StatelessWidget {
  final Widget? icon;
  final Function()? onTap;
  final String title;
  final String? subtitle;
  final Widget? actions;
  final double? elevation;

  const ListSurface({
    super.key,
    this.icon,
    this.onTap,
    required this.title,
    this.subtitle,
    this.actions,
    this.elevation,
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
              elevation: (elevation ?? 0) + 4,
              child: SizedBox(
                width: 72,
                height: 72,
                child: Center(child: icon),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: subtitle != null ? SecondaryText(subtitle!) : null,
                trailing: actions,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
