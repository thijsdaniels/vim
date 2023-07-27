import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.radius = 16,
    this.onTap,
  });

  final User user;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var initials = user.initials;

    return Hero(
      tag: 'user-avatar',
      child: IconButton(
        onPressed: onTap,
        icon: CircleAvatar(
          radius: radius,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          backgroundImage: user.portrait,
          child: user.portrait == null
              ? initials != null
                  ? Text(
                      initials,
                      style: TextStyle(
                        fontSize: radius * 0.8,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const Icon(Icons.person)
              : null,
        ),
      ),
    );
  }
}
