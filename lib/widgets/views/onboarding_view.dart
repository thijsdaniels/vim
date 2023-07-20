import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/settings_model.dart';
import 'package:vim/models/user/body.dart';
import 'package:vim/models/user/target.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/slider_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/switch_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

/// TODO: This file contains a lot of code that was duplicated from the
/// `SettingsView`. I should Make sure that most widgets in these two files can
/// be used by both the `OnboardingView` and the `SettingsView` and then get rid
/// of the duplicates.

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
      weight: 70,
      composition: BodyComposition(
        lean: 0.8,
        fat: 0.15,
        bone: 0.5,
      ),
    ),
    neat: 400,
    target: Target(
      consumption: ConsumptionTarget(surplus: 0, proteins: 1.6, fats: 0.25),
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
        title: const Text('Profile'),
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
        spacing: 16,
        children: [
          const ProfileSettings(),
          BodySettings(user: _user, onChanged: onUserChanged),
          PerformanceSettings(user: _user, onChanged: onUserChanged),
          ConsumptionSettings(user: _user, onChanged: onUserChanged),
          const AppearanceSettings(),
        ],
      ),
      bottomNavigationBar: FilledButton(
        onPressed: () {
          widget.onComplete(_user);
        },
        child: const Text('Complete'),
      ),
    );
  }

  void onUserChanged(User user) {
    setState(() {
      _user = user;
    });
  }
}

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

class BodySettings extends StatelessWidget {
  const BodySettings({
    super.key,
    required this.user,
    required this.onChanged,
  });

  final User user;
  final void Function(User user) onChanged;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      title: 'Body',
      child: Column(
        children: [
          DropdownButtonFormField(
            decoration: const InputDecoration(
              label: Text('Gender'),
            ),
            value: user.body.gender,
            items: Gender.values
                .map(
                  (gender) => DropdownMenuItem(
                    value: gender,
                    child: Text(gender.name.toTitleCase()),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                user.body.gender = value;
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('Age'),
            ),
            initialValue: user.body.age,
            onChanged: (value) {
              if (value != null) {
                user.body.age = value.toInt();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('Length'),
              hintText: 'Centimeters',
            ),
            initialValue: user.body.length,
            onChanged: (value) {
              if (value != null) {
                user.body.length = value.toInt();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('Weight'),
              hintText: 'Kilograms',
            ),
            initialValue: user.body.weight,
            onChanged: (value) {
              if (value != null) {
                user.body.weight = value.toDouble();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('Lean Mass'),
              hintText: 'Percentage',
            ),
            initialValue: user.body.composition.lean != null
                ? (user.body.composition.lean! * 100).decimals(1)
                : null,
            onChanged: (value) {
              if (value != null) {
                user.body.composition.lean = (value / 100).toDouble();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('Fat Mass'),
              hintText: 'Percentage',
            ),
            initialValue: user.body.composition.fat != null
                ? (user.body.composition.fat! * 100).decimals(1)
                : null,
            onChanged: (value) {
              if (value != null) {
                user.body.composition.fat = (value / 100).toDouble();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('Bone Mass'),
              hintText: 'Percentage',
            ),
            initialValue: user.body.composition.bone != null
                ? (user.body.composition.bone! * 100).decimals(1)
                : null,
            onChanged: (value) {
              if (value != null) {
                user.body.composition.bone = (value / 100).toDouble();
                onChanged(user);
              }
            },
          ),
        ],
      ),
    );
  }
}

class PerformanceSettings extends StatelessWidget {
  const PerformanceSettings({
    super.key,
    required this.user,
    required this.onChanged,
  });

  final User user;
  final void Function(User user) onChanged;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      title: 'Performance',
      child: Column(
        children: [
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('NEAT'),
            ),
            initialValue: user.neat,
            onChanged: (value) {
              if (value != null) {
                user.neat = value.toDouble();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          NumberFormField(
            decoration: const InputDecoration(
              label: Text('Target Exercise'),
            ),
            initialValue: user.target.performance.calories,
            onChanged: (value) {
              if (value != null) {
                user.target.performance.calories = value.toInt();
                onChanged(user);
              }
            },
          ),
          const SizedBox(height: 16),
          SwitchFormField(
            label: const Text('Adjust Target Consumption'),
            value: user.target.performance.adjustTargetConsumption,
            onChanged: (value) {
              user.target.performance.adjustTargetConsumption = value;
              onChanged(user);
            },
          ),
        ],
      ),
    );
  }
}

class ConsumptionSettings extends StatelessWidget {
  const ConsumptionSettings({
    super.key,
    required this.user,
    required this.onChanged,
  });

  final User user;
  final void Function(User user) onChanged;

  @override
  Widget build(BuildContext context) {
    return SimpleCard(
      title: 'Consumption',
      child: Column(
        children: [
          const SizedBox(height: 16),
          SliderFormField(
            label: const Text('Surplus'),
            valueLabel: '${(user.target.consumption.surplus * 100).round()}%',
            min: -0.2,
            max: 0.2,
            divisions: 8,
            value: user.target.consumption.surplus,
            onChanged: (value) {
              user.target.consumption.surplus = value.decimals(2);
              onChanged(user);
            },
          ),
          const SizedBox(height: 16),
          SliderFormField(
            label: const Text('Carbs'),
            valueLabel:
                '${(user.targetCarbohydrateConsumption * 100).round()}%',
            value: user.targetCarbohydrateConsumption,
            divisions: 100,
            secondaryTrackValue: (1 -
                    user.targetProteinConsumption -
                    user.target.consumption.fats)
                .clamp(0, 1),
            enabled: false,
          ),
          const SizedBox(height: 16),
          SliderFormField(
            label: const Text('Proteins'),
            valueLabel: '${(user.target.consumption.proteins).decimals(1)}g',
            value: user.target.consumption.proteins,
            min: 0,
            max: 3,
            divisions: 30,
            onChanged: (value) {
              user.target.consumption.proteins = value.decimals(1);
              onChanged(user);
            },
          ),
          const SizedBox(height: 16),
          SliderFormField(
            label: const Text('Fats'),
            valueLabel: '${(user.target.consumption.fats * 100).round()}%',
            value: user.target.consumption.fats,
            divisions: 100,
            // secondaryTrackValue: (1 - settings.body.carbohydrates - settings.body.proteins).clamp(0, 1),
            onChanged: (value) {
              // if (settings.body.carbohydrates + settings.body.proteins + value <= 1) {
              user.target.consumption.fats = value.decimals(2);
              onChanged(user);
              // }
            },
          ),
        ],
      ),
    );
  }
}

class AppearanceSettings extends StatelessWidget {
  const AppearanceSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, settings, _) => SimpleCard(
        title: 'Appearance',
        child: Column(
          children: [
            DropdownButtonFormField<ThemeMode>(
              decoration: const InputDecoration(
                label: Text('Theme'),
              ),
              value: settings.themeMode,
              items: ThemeMode.values
                  .map(
                    (mode) => DropdownMenuItem<ThemeMode>(
                      value: mode,
                      child: Text(mode.name.toTitleCase()),
                    ),
                  )
                  .toList(),
              onChanged: (mode) {
                if (mode != null) {
                  settings.themeMode = mode;
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Color>(
              decoration: const InputDecoration(
                label: Text('Color'),
              ),
              value: settings.color,
              items: Colors.primaries
                  .map(
                    (color) => DropdownMenuItem<Color>(
                      value: color,
                      child: Container(
                        width: 96,
                        height: 24,
                        color: color,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (color) {
                if (color != null) {
                  settings.color = color;
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Icons8Style>(
              decoration: const InputDecoration(
                label: Text('Icon Set'),
              ),
              value: settings.iconStyle,
              items: Icons8Style.values
                  .map(
                    (style) => DropdownMenuItem<Icons8Style>(
                      value: style,
                      child: Row(
                        children: [
                          Icons8Icon('apple', style: style, size: 24),
                          const SizedBox(width: 12),
                          Text(style.name.toTitleCase()),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (style) {
                if (style != null) {
                  settings.iconStyle = style;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
