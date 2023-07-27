import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/user_list_surface.dart';

class UsersList extends StatelessWidget {
  const UsersList(this.users, {super.key});

  final List<User> users;

  @override
  Widget build(BuildContext context) {
    return StandardList(
      spacing: 12,
      itemCount: users.length,
      itemBuilder: (context, index) => UserListSurface(
        user: users[index],
        // onTap: () {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => UserView(
        //         id: users[index].reference!.id,
        //       ),
        //     ),
        //   );
        // },
      ),
    );
  }
}
