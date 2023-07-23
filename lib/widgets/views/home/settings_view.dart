import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/distance.dart';
import 'package:vim/models/food/nutrition.dart';
import 'package:vim/models/mass.dart';
import 'package:vim/models/settings_model.dart';
import 'package:vim/models/user/body.dart';
import 'package:vim/models/user/user.dart';
import 'package:vim/services/users_collection.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/slider_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/atoms/switch_form_field.dart';
import 'package:vim/widgets/molecules/simple_card.dart';
import 'package:vim/widgets/views/home/debug_view.dart';

/// TODO: This file contains a lot of code that was duplicated from the
/// `OnboardingView`. I should Make sure that most widgets in these two files
/// can be used by both the `OnboardingView` and the `SettingsView` and then get
/// rid of the duplicates.

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const DebugView(),
                ),
              );
            },
            icon: const Icon(Icons.developer_mode),
          ),
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
      body: const StandardList(
        children: [
          ProfileSettings(),
          BodySettings(),
          PerformanceSettings(),
          ConsumptionSettings(),
          AppearanceSettings(),
        ],
      ),
    );
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
      child: StandardList(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
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
          TextFormField(
            decoration: const InputDecoration(
              label: Text('Email'),
            ),
            initialValue: FirebaseAuth.instance.currentUser!.email!,
            enabled: false,
          ),
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
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<User?>(
      builder: (context, user, _) {
        if (user == null) {
          return const CircularProgressIndicator();
        }

        return SimpleCard(
          title: 'Body',
          child: StandardList(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
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
                    UsersCollection.instance.update(user);
                  }
                },
              ),
              NumberFormField(
                decoration: const InputDecoration(
                  label: Text('Age'),
                ),
                initialValue: user.body.age,
                onChanged: (value) {
                  if (value != null) {
                    user.body.age = value.toInt();
                    UsersCollection.instance.update(user);
                  }
                },
              ),
              NumberFormField(
                decoration: const InputDecoration(
                  label: Text('Length'),
                  hintText: 'Centimeters',
                ),
                initialValue: user.body.length?.centimeters,
                onChanged: (value) {
                  if (value != null) {
                    user.body.length = Distance.centimeters(value.toInt());
                    UsersCollection.instance.update(user);
                  }
                },
              ),
              NumberFormField(
                decoration: const InputDecoration(
                  label: Text('Weight'),
                  hintText: 'Kilograms',
                ),
                initialValue: user.body.weight.kilograms,
                onChanged: (value) {
                  if (value != null) {
                    user.body.weight = Mass.kilograms(value.toDouble());
                    UsersCollection.instance.update(user);
                  }
                },
              ),
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
                    UsersCollection.instance.update(user);
                  }
                },
              ),
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
                    UsersCollection.instance.update(user);
                  }
                },
              ),
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
                    UsersCollection.instance.update(user);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class PerformanceSettings extends StatelessWidget {
  const PerformanceSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<User?>(
      builder: (context, user, _) {
        if (user == null) {
          return const CircularProgressIndicator();
        }

        return SimpleCard(
          title: 'Performance',
          child: StandardList(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              NumberFormField(
                decoration: const InputDecoration(
                  label: Text('NEAT'),
                ),
                initialValue: user.neat,
                onChanged: (value) {
                  if (value != null) {
                    user.neat = value.toDouble();
                    UsersCollection.instance.update(user);
                  }
                },
              ),
              NumberFormField(
                decoration: const InputDecoration(
                  label: Text('Target Exercise'),
                ),
                initialValue: user.target.performance.calories,
                onChanged: (value) {
                  if (value != null) {
                    user.target.performance.calories = value.toInt();
                    UsersCollection.instance.update(user);
                  }
                },
              ),
              SwitchFormField(
                label: const Text('Adjust Target Consumption'),
                value: user.target.performance.adjustTargetConsumption,
                onChanged: (value) {
                  user.target.performance.adjustTargetConsumption = value;
                  UsersCollection.instance.update(user);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// TODO: Don't save the `User` every time a value changes. Instead, only save
/// the `User` in the `onChangeEnd` handler of the `SliderFormField`.
class ConsumptionSettings extends StatelessWidget {
  const ConsumptionSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<User?>(
      builder: (context, user, _) {
        if (user == null) {
          return const CircularProgressIndicator();
        }

        // In grams of protein per kilograms of bodyweight.
        double maxProteins = ((1 - user.target.consumption.fats) *
            user.targetConsumption /
            Proteins.caloriesPerGram /
            user.body.weight.kilograms);

        // As a fraction of the total target calorie consumption.
        double maxFats = 1 - user.targetProteinConsumption;

        return SimpleCard(
          title: 'Consumption',
          child: StandardList(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              SliderFormField(
                label: const Text('Surplus'),
                valueLabel:
                    '${(user.target.consumption.surplus * 100).round()}%',
                min: -0.2,
                max: 0.2,
                divisions: 8,
                value: user.target.consumption.surplus,
                onChanged: (value) {
                  user.target.consumption.surplus = value.decimals(2);
                  UsersCollection.instance.update(user);
                },
              ),
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
              ),
              SliderFormField(
                label: const Text('Proteins'),
                valueLabel:
                    '${(user.target.consumption.proteins).decimals(1)}g',
                value: user.target.consumption.proteins,
                min: 0,
                max: 3,
                divisions: 30,
                secondaryTrackValue: maxProteins.clamp(0, 3),
                onChanged: (value) {
                  if (value < maxProteins) {
                    user.target.consumption.proteins = value.decimals(1);
                    UsersCollection.instance.update(user);
                  }
                },
              ),
              SliderFormField(
                label: const Text('Fats'),
                valueLabel: '${(user.target.consumption.fats * 100).round()}%',
                value: user.target.consumption.fats,
                divisions: 100,
                secondaryTrackValue: maxFats.clamp(0, 1),
                onChanged: (value) {
                  if (value < maxFats) {
                    user.target.consumption.fats = value.decimals(2);
                    UsersCollection.instance.update(user);
                  }
                },
              ),
            ],
          ),
        );
      },
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
        child: StandardList(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
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
