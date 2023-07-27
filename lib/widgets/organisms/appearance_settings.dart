import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/extensions/string.dart';
import 'package:vim/models/settings_model.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';
import 'package:vim/widgets/atoms/standard_list.dart';
import 'package:vim/widgets/molecules/simple_card.dart';

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
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
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
