import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/users_collection.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/organisms/appearance_settings.dart';
import 'package:vim/widgets/organisms/body_settings.dart';
import 'package:vim/widgets/organisms/consumption_settings.dart';
import 'package:vim/widgets/organisms/performance_settings.dart';
import 'package:vim/widgets/organisms/profile_settings.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          PopupMenuButton(
            tooltip: '',
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: FirebaseAuth.instance.signOut,
                child: const Text('Sign Out'),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<User>(
        builder: (context, user, _) => StandardList(
          children: [
            const ProfileSettings(),
            BodySettings(user: user, onChanged: onChanged),
            PerformanceSettings(user: user, onChanged: onChanged),
            ConsumptionSettings(user: user, onChanged: onChanged),
            const AppearanceSettings(),
          ],
        ),
      ),
    );
  }

  /// TODO: Don't update the user on every change, but rather on save.
  void onChanged(User user) {
    UsersCollection.instance.update(user);
  }
}
