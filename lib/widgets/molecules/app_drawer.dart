import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/views/debug_view.dart';
import 'package:vim/views/equipments/equipments_view.dart';
import 'package:vim/views/exercises/exercises_view.dart';
import 'package:vim/views/routines/routines_view.dart';
import 'package:vim/views/ingredients/ingredients_view.dart';
import 'package:vim/views/recipes/recipes_view.dart';
import 'package:vim/views/log/log_view.dart';
import 'package:vim/views/settings_view.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var user = User.of(context);

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Log'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LogView(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  title: const Text('Ingredients'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const IngredientsView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Recipes'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const RecipesView(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  title: const Text('Equipment'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const EquipmentsView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Exercises'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const ExercisesView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Routines'),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const RoutinesView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Plans'),
                  enabled: false,
                ),
              ],
            ),
          ),
          if (user.isAdmin)
            ListTile(
              leading: Icon(Icons.bug_report),
              title: const Text('Debug'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DebugView(),
                  ),
                );
              },
            ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Sign Out'),
            onTap: FirebaseAuth.instance.signOut,
          ),
        ],
      ),
    );
  }
}
