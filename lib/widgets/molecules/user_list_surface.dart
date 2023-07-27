import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/molecules/list_surface.dart';

class UserListSurface extends StatelessWidget {
  final void Function()? onTap;
  final double? elevation;

  const UserListSurface({
    super.key,
    required this.user,
    this.onTap,
    this.elevation,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    var myUser = User.of(context);

    return ListSurface(
      elevation: elevation,
      icon: null,
      title: user.reference!.id,
      onTap: onTap,
      trailing: IconButton(
        icon: myUser.following.contains(user.reference)
            ? const Icon(Icons.check_box_outlined)
            : const Icon(Icons.check_box_outline_blank),
        onPressed: () {
          if (myUser.following.contains(user.reference)) {
            myUser.unfollow(user);
          } else {
            myUser.follow(user);
          }
        },
      ),
    );
  }
}
