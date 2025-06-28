import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/models/date_model.dart';
import 'package:vim/models/settings_model.dart';
import 'package:vim/router.dart';

class Vim extends StatelessWidget {
  const Vim({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StateProviders(
      child: Consumer<SettingsModel>(
        builder: (context, settingsModel, _) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Vim',
          theme: lightTheme(settingsModel.color),
          darkTheme: darkTheme(settingsModel.color),
          themeMode: settingsModel.themeMode,
          routerConfig: router,
        ),
      ),
    );
  }
}

class StateProviders extends StatelessWidget {
  final Widget child;

  const StateProviders({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<FragmentProgram?>.value(
          initialData: null,
          value:
              FragmentProgram.fromAsset('assets/shaders/surface_shader.frag'),
        ),
        ChangeNotifierProvider<DateModel>.value(
          value: DateModel(),
        ),
        ChangeNotifierProvider<SettingsModel>.value(
          value: SettingsModel(),
        ),
      ],
      child: child,
    );
  }
}

var lightTheme = (Color seedColor) => theme(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: seedColor,
      ),
    );

var darkTheme = (Color seedColor) => theme(
      colorScheme: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: seedColor,
      ),
    );

var theme = ({
  required ColorScheme colorScheme,
}) =>
    ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'GoogleSans',
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      cardColor: Colors.black,
      sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
      ),
    );
