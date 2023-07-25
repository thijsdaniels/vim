import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';

class SettingsModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  Color _color = Colors.deepPurple;

  Icons8Style _iconStyle = Icons8Style.stickers;

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

  Icons8Style get iconStyle => _iconStyle;

  set iconStyle(Icons8Style style) {
    _iconStyle = style;
    notifyListeners();
  }

  SettingsModel();

  factory SettingsModel.of(BuildContext context) {
    return Provider.of<SettingsModel>(context, listen: false);
  }
}
