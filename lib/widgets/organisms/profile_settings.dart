import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage:
                    FirebaseAuth.instance.currentUser!.photoURL != null
                        ? NetworkImage(
                            FirebaseAuth.instance.currentUser!.photoURL!,
                          )
                        : null,
                child: Text(
                  FirebaseAuth.instance.currentUser!.email!
                      .substring(0, 2)
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
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
