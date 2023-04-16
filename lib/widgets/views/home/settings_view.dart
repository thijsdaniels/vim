import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/num.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/body.dart';
import 'package:vim/models/settings_model.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/number_form_field.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: PopupMenuButton(
                tooltip: '',
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: FirebaseAuth.instance.signOut,
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
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
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, settings, _) => SimpleCard(
        title: 'Body',
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(
                label: Text('Gender'),
              ),
              value: settings.body.gender,
              items: Gender.values
                  .map(
                    (gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender.name.toTitleCase()),
                    ),
                  )
                  .toList(),
              onChanged: (gender) {
                if (gender != null) {
                  settings.body = settings.body.copyWith(
                    gender: gender,
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            NumberFormField(
              decoration: const InputDecoration(
                label: Text('Age'),
              ),
              initialValue: settings.body.age,
              onChanged: (age) {
                if (age != null) {
                  settings.body = settings.body.copyWith(
                    age: age.toDouble(),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            NumberFormField(
              decoration: const InputDecoration(
                label: Text('Length'),
                hintText: 'Centimeters',
              ),
              initialValue: settings.body.length,
              onChanged: (length) {
                if (length != null) {
                  settings.body = settings.body.copyWith(
                    length: length.toDouble(),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            NumberFormField(
              decoration: const InputDecoration(
                label: Text('Weight'),
                hintText: 'Kilograms',
              ),
              initialValue: settings.body.weight,
              onChanged: (weight) {
                if (weight != null) {
                  settings.body = settings.body.copyWith(
                    weight: weight.toDouble(),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            NumberFormField(
              decoration: const InputDecoration(
                label: Text('Muscle'),
                hintText: 'Percentage',
              ),
              initialValue: settings.body.muscle,
              onChanged: (muscle) {
                if (muscle != null) {
                  settings.body = settings.body.copyWith(
                    muscle: muscle.toDouble(),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            NumberFormField(
              decoration: const InputDecoration(
                label: Text('Fat'),
                hintText: 'Percentage',
              ),
              initialValue: settings.body.fat,
              onChanged: (fat) {
                if (fat != null) {
                  settings.body = settings.body.copyWith(
                    fat: fat.toDouble(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PerformanceSettings extends StatelessWidget {
  const PerformanceSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, settings, _) => SimpleCard(
        title: 'Performance',
        child: Column(
          children: [
            NumberFormField(
              decoration: const InputDecoration(
                label: Text('NEAT'),
              ),
              initialValue: settings.body.neat,
              onChanged: (neat) {
                if (neat != null) {
                  settings.body = settings.body.copyWith(
                    neat: neat.toDouble(),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            NumberFormField(
              decoration: const InputDecoration(
                label: Text('Target Exercise'),
              ),
              initialValue: settings.body.exercise,
              onChanged: (exercise) {
                if (exercise != null) {
                  settings.body = settings.body.copyWith(
                    exercise: exercise.toInt(),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Adjust Target Intake'),
                Switch(
                  value: settings.body.adjustIntake,
                  onChanged: (adjustIntake) {
                    settings.body = settings.body.copyWith(
                      adjustIntake: adjustIntake,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ConsumptionSettings extends StatelessWidget {
  const ConsumptionSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, settings, _) => SimpleCard(
        title: 'Consumption',
        child: Column(
          children: [
            const SizedBox(height: 16),
            SliderFormField(
              label: const Text('Surplus'),
              valueLabel: '${(settings.body.surplus * 100).round()}%',
              min: -0.2,
              max: 0.2,
              divisions: 8,
              value: settings.body.surplus,
              onChanged: (surplus) {
                settings.body = settings.body.copyWith(
                  surplus: surplus,
                );
              },
            ),
            const SizedBox(height: 16),
            SliderFormField(
              label: const Text('Carbs'),
              valueLabel: '${(settings.body.carbohydrates * 100).round()}%',
              value: settings.body.carbohydrates,
              divisions: 100,
              secondaryTrackValue:
                  (1 - settings.body.proteins - settings.body.fats).clamp(0, 1),
              enabled: false,
            ),
            const SizedBox(height: 16),
            SliderFormField(
              label: const Text('Proteins'),
              valueLabel: '${(settings.body.proteinGramsPerKilo).decimals(1)}g',
              value: settings.body.proteinGramsPerKilo,
              min: 0,
              max: 3,
              divisions: 30,
              onChanged: (proteinGramsPerKilo) {
                settings.body = settings.body.copyWith(
                  proteinGramsPerKilo: proteinGramsPerKilo,
                );
              },
            ),
            const SizedBox(height: 16),
            SliderFormField(
              label: const Text('Fats'),
              valueLabel: '${(settings.body.fats * 100).round()}%',
              value: settings.body.fats,
              divisions: 100,
              // secondaryTrackValue:
              //     (1 - settings.body.carbohydrates - settings.body.proteins)
              //         .clamp(0, 1),
              onChanged: (fats) {
                // if (settings.body.carbohydrates +
                //         settings.body.proteins +
                //         fats <=
                //     1) {
                settings.body = settings.body.copyWith(
                  fats: fats,
                );
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SliderFormField extends StatelessWidget {
  final double value;
  final void Function(double value)? onChanged;
  final double? secondaryTrackValue;
  final Widget? label;
  final String? valueLabel;
  final double min;
  final double max;
  final int? divisions;
  final bool? enabled;

  const SliderFormField({
    super.key,
    required this.value,
    this.onChanged,
    this.secondaryTrackValue,
    this.label,
    this.valueLabel,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.enabled,
  }) : assert(
          onChanged != null || enabled == false,
          'An onChanged handler must be provided if the field is not disabled.',
        );

  @override
  build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null || valueLabel != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              label ?? const SizedBox(),
              valueLabel != null ? Text(valueLabel!) : const SizedBox(),
            ],
          ),
        if (enabled != false)
          Slider(
            value: value,
            onChanged: onChanged,
            secondaryTrackValue: secondaryTrackValue,
            label: valueLabel,
            min: min,
            max: max,
            divisions: divisions,
          ),
        if (enabled == false)
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: (value - min) / (max - min),
                minHeight: 6,
              ),
            ),
          ),
      ],
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
              value: settings.mode,
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
                  settings.mode = mode;
                }
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Icons8Style>(
              decoration: const InputDecoration(
                label: Text('Icon Set'),
              ),
              value: settings.style,
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
                  settings.style = style;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
