import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/surface.dart';

class ListSurface extends StatelessWidget {
  final Widget? icon;
  final Function()? onTap;
  final Widget title;
  final Widget? subtitle;

  const ListSurface({
    super.key,
    this.icon,
    this.onTap,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Surface(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Surface(
            elevation: 4,
            child: SizedBox(
              width: 72,
              height: 72,
              child: Center(child: icon),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              onTap: onTap,
              title: title,
              subtitle: subtitle,
            ),
          ),
        ],
      ),
    );
  }
}
