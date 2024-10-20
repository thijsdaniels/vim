import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/views/debug_view.dart';
import 'package:vim/views/equipments/equipments_view.dart';
import 'package:vim/views/exercises/exercises_view.dart';
import 'package:vim/views/routines/routines_view.dart';
import 'package:vim/views/ingredients/ingredients_view.dart';
import 'package:vim/views/recipes/recipes_view.dart';
import 'package:vim/views/settings_view.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

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
                  selected: true,
                  // onTap: () {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => const LogView(),
                  //     ),
                  //   );
                  // },
                ),
                Divider(),
                ListTile(
                  title: const Text('Ingredients'),
                  selected: false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const IngredientsView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Recipes'),
                  selected: false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RecipesView(),
                      ),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  title: const Text('Equipment'),
                  selected: false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const EquipmentsView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Exercises'),
                  selected: false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ExercisesView(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Routines'),
                  selected: false,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const RoutinesView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          if (user.isAdmin)
            ListTile(
              leading: Icon(Icons.bug_report),
              title: const Text('Debug'),
              selected: false,
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
            selected: false,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsView(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
