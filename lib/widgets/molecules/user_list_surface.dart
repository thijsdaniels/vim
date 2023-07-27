import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/user_icon.dart';
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
      icon: UserIcon(user),
      title: user.name ?? 'Anonymous',
      onTap: onTap,
      trailing: Checkbox(
        value: myUser.following.contains(user.reference),
        onChanged: (value) {
          if (value == true) {
            myUser.follow(user);
          } else {
            myUser.unfollow(user);
          }
        },
      ),
    );
  }
}
