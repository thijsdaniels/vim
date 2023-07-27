import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/users_collection.dart';
import 'package:vim/widgets/molecules/users_list.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: UsersCollection.instance.all(),
          builder: (context, users) => UsersList(
            users.data
                    ?.whereNot(
                      (user) =>
                          user.reference!.path ==
                          User.of(context).reference!.path,
                    )
                    .toList() ??
                [],
          ),
        ),
      ),
    );
  }
}
