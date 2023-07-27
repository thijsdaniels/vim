import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/surface.dart';

class UserIcon extends StatelessWidget {
  final User user;
  final double? elevation;

  const UserIcon(
    this.user, {
    super.key,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    var initials = user.initials;

    return Surface(
      isPrimary: true,
      child: Center(
        child: initials != null
            ? Text(
                initials,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const Icon(Icons.person),
      ),
    );
  }
}
