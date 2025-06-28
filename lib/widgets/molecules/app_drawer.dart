import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/user_avatar.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var user = User.of(context);
    var router = GoRouter.of(context);

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
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              NavigationListTile(
                                icon: Icons.list,
                                label: 'Log',
                                onTap: () => router.go('/log'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              NavigationListTile(
                                icon: Icons.egg,
                                label: 'Products',
                                onTap: () => router.go('/ingredients'),
                              ),
                              NavigationListTile(
                                icon: Icons.article,
                                label: 'Recipes',
                                onTap: () => router.go('/recipes'),
                              ),
                              const NavigationListTile(
                                icon: Icons.fastfood,
                                label: 'Meals',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color:
                            Theme.of(context).colorScheme.surfaceContainerHigh,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Column(
                            children: [
                              NavigationListTile(
                                icon: Icons.fitness_center,
                                label: 'Equipment',
                                onTap: () => router.go('/equipments'),
                              ),
                              NavigationListTile(
                                icon: Icons.sports_gymnastics,
                                label: 'Exercises',
                                onTap: () => router.go('/exercises'),
                              ),
                              NavigationListTile(
                                icon: Icons.checklist,
                                label: 'Routines',
                                onTap: () => router.go('/routines'),
                              ),
                              const NavigationListTile(
                                icon: Icons.schedule,
                                label: 'Plans',
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
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Column(
              children: [
                if (user.isAdmin)
                  NavigationListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    icon: Icons.bug_report,
                    label: 'Debug',
                    onTap: () => router.go('/debug'),
                  ),
                NavigationListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () => router.push('/settings'),
                ),
                NavigationListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  icon: Icons.exit_to_app,
                  label: 'Sign Out',
                  onTap: FirebaseAuth.instance.signOut,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationListTile extends StatelessWidget {
  const NavigationListTile({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.contentPadding,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 20,
      minTileHeight: 36,
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
      enabled: onTap != null,
      contentPadding: contentPadding,
    );
  }
}
