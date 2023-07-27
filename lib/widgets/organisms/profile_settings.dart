import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/user_avatar.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({
    super.key,
    required this.user,
    required this.onChanged,
  });

  final User user;
  final void Function(User user) onChanged;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      title: 'Profile',
      child: StandardList(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserAvatar(
                user: User.of(context),
                radius: 96,
              ),
            ],
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Name'),
              hintText: 'Anonymous',
            ),
            initialValue: user.name,
            onChanged: (name) {
              user.name = name.isNotEmpty ? name : null;
              onChanged(user);
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
            initialValue:
                firebase_auth.FirebaseAuth.instance.currentUser!.email!,
            enabled: false,
          ),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Password'),
            ),
            initialValue: '',
            enabled: false,
          ),
        ],
      ),
    );
  }
}
