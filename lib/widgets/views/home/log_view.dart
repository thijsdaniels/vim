import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vim/widgets/atoms/surface.dart';
import 'package:vim/widgets/atoms/user_avatar.dart';
import 'package:vim/widgets/molecules/date_stepper.dart';
import 'package:vim/widgets/views/home/debug_view.dart';
import 'package:vim/widgets/views/home/log/log_consumptions_view.dart';
import 'package:vim/widgets/views/home/log/log_performances_view.dart';
import 'package:vim/widgets/views/home/log/log_progress_view.dart';
import 'package:vim/widgets/views/home/settings_view.dart';

class LogView extends StatelessWidget {
  const LogView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Log'),
          actions: [
            if (FirebaseAuth.instance.currentUser!.email ==
                'thijsdaniels89@gmail.com')
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DebugView(),
                    ),
                  );
                },
                icon: const Icon(Icons.bug_report),
              ),
            UserAvatar(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsView(),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Status'),
              Tab(text: 'Consumptions'),
              Tab(text: 'Performances'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            LogProgressView(),
            LogConsumptionsView(),
            LogPerformancesView(),
          ],
        ),
        bottomNavigationBar: const Surface(
          isPrimary: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: DateStepper(),
          ),
        ),
      ),
    );
  }
}
