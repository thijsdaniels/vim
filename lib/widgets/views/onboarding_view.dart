import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:vim/models/distance.dart';
import 'package:vim/models/mass.dart';
import 'package:vim/models/user/body.dart';
import 'package:vim/models/user/target.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/with_confirmation_dialog.dart';
import 'package:vim/widgets/organisms/body_settings.dart';
import 'package:vim/widgets/organisms/consumption_settings.dart';
import 'package:vim/widgets/organisms/performance_settings.dart';
import 'package:vim/widgets/organisms/profile_settings.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({
    super.key,
    required this.onComplete,
  });

  final void Function(User user) onComplete;

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  User _user = User(
    body: Body(
      weight: const Mass.kilograms(70),
      length: const Distance.centimeters(175),
      composition: BodyComposition(
        lean: 0.8,
        fat: 0.15,
        bone: 0.05,
      ),
    ),
    neat: 592.35,
    target: Target(
      consumption: ConsumptionTarget(
        surplus: 0,
        proteins: 1.6,
        fats: 0.25,
      ),
      performance: PerformanceTarget(
        calories: 400,
        adjustTargetConsumption: true,
      ),
    ),
  );

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
      body: StandardList(
        children: [
          const ProfileSettings(),
          BodySettings(user: _user, onChanged: onUserChanged),
          PerformanceSettings(user: _user, onChanged: onUserChanged),
          ConsumptionSettings(user: _user, onChanged: onUserChanged),
        ],
      ),
      bottomNavigationBar: WithConfirmationDialog(
        title: 'Are you sure?',
        description:
            'These settings affect your consumption and performance targets. Don\'t worry, you can always change them later.',
        builder: (context, confirm) => FilledButton(
          onPressed: () async {
            if (await confirm()) {
              widget.onComplete(_user);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            padding: const EdgeInsets.all(24),
          ),
          child: const Text('Continue'),
        ),
      ),
    );
  }

  void onUserChanged(User user) {
    setState(() {
      _user = user;
    });
  }
}
