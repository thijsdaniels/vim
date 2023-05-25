import 'package:flutter/material.dart';
import 'package:vim/models/body.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';

class SettingsModel extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  Icons8Style _iconStyle = Icons8Style.arcade;

  Body _body = Body(
    gender: Gender.male,
    age: 34,
    length: 176,
    weight: 67.0,
    muscle: 79.3,
    fat: 16.4,
    neat: 400,
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
