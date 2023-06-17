import 'package:flutter/material.dart';
import 'package:vim/models/body.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';

class SettingsModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  Color _color = Colors.deepPurple;

  Icons8Style _iconStyle = Icons8Style.stickers;

  Body _body = Body(
    gender: Gender.male,
    age: 34,
    length: 176,
    weight: 66.6,
    muscle: 81.0,
    fat: 14.7,
    neat: 400.3704,
    exercise: 400,
    surplus: -0.05,
    proteinGramsPerKilo: 1.8,
    fats: 0.2,
  );

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

  Body get body => _body;

  set body(Body body) {
    _body = body;
    notifyListeners();
  }
}
