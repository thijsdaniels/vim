import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/views/debug_view.dart';
import 'package:vim/views/equipments/equipments_view.dart';
import 'package:vim/views/exercises/exercises_view.dart';
import 'package:vim/views/ingredients/ingredients_view.dart';
import 'package:vim/views/recipes/recipes_view.dart';
import 'package:vim/views/routines/routines_view.dart';
import 'package:vim/views/settings_view.dart';
import 'package:vim/widgets/atoms/user_avatar.dart';

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
                SizedBox(
                  height: 128,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        UserAvatar(user: user, radius: 24),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name ?? 'Anonymous',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              FirebaseAuth.instance.currentUser?.email ?? "",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              ListTile(
                                dense: true,
                                leading: Icon(Icons.egg, size: 20),
                                title: const Text('Products'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const IngredientsView(),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                leading: Icon(Icons.article, size: 20),
                                title: const Text('Recipes'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const RecipesView(),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                enabled: false,
                                leading: const Icon(Icons.fastfood, size: 20),
                                title: const Text('Meals'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            children: [
                              ListTile(
                                dense: true,
                                leading: Icon(Icons.fitness_center, size: 20),
                                title: const Text('Equipment'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EquipmentsView(),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                leading:
                                    Icon(Icons.sports_gymnastics, size: 20),
                                title: const Text('Exercises'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ExercisesView(),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                leading: Icon(Icons.checklist, size: 20),
                                title: const Text('Routines'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const RoutinesView(),
                                    ),
                                  );
                                },
                              ),
                              ListTile(
                                dense: true,
                                leading: Icon(Icons.schedule, size: 20),
                                title: const Text('Plans'),
                                enabled: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        if (user.isAdmin)
                          ListTile(
                            dense: true,
                            leading: Icon(Icons.bug_report, size: 20),
                            title: const Text('Debug'),
                            onTap: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DebugView(),
                                ),
                              );
                            },
                          ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.settings, size: 20),
                          title: const Text('Settings'),
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SettingsView(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          dense: true,
                          leading: Icon(Icons.exit_to_app, size: 20),
                          title: const Text('Sign Out'),
                          onTap: FirebaseAuth.instance.signOut,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
