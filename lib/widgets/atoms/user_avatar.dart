import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.radius = 16,
    this.onTap,
  });

  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    var photo = FirebaseAuth.instance.currentUser!.photoURL != null
        ? NetworkImage(
            FirebaseAuth.instance.currentUser!.photoURL!,
          )
        : null;

    var initials = FirebaseAuth.instance.currentUser!.photoURL == null
        ? Text(
            FirebaseAuth.instance.currentUser!.email!
                .substring(0, 2)
                .toUpperCase(),
            style: TextStyle(fontSize: radius * 0.8),
          )
        : null;

    return Hero(
      tag: 'user-avatar',
      child: IconButton(
        onPressed: onTap,
        icon: CircleAvatar(
          radius: radius,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          backgroundImage: photo,
          child: initials,
        ),
      ),
    );
  }
}
