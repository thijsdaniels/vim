import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  Color _color = Colors.deepPurple;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  Color get color => _color;

  set color(Color color) {
    _color = color;
    notifyListeners();
  }

  SettingsModel();

  factory SettingsModel.of(BuildContext context) {
    return Provider.of<SettingsModel>(context, listen: false);
  }
}
