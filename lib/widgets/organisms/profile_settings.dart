import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/user_avatar.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      title: 'Profile',
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserAvatar(radius: 64),
            ],
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
            initialValue: FirebaseAuth.instance.currentUser!.email!,
            enabled: false,
          ),
          const SizedBox(height: 16),
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
