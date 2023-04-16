import 'package:flutter/material.dart';
import 'package:vim/models/body.dart';
import 'package:vim/widgets/atoms/icons8_icon.dart';

class SettingsModel extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  Icons8Style _style = Icons8Style.stickers;

  Body _body = Body(
    gender: Gender.male,
    age: 33,
    weight: 66.5,
    length: 176,
    muscle: 81.0,
    fat: 14.8,
    neat: 300, // a rough estimate
    surplus: -0.05,
    exercise: 400,
    // carbohydrates: 0.45,
    proteinGramsPerKilo: 1.6,
    fats: 0.3,
  );

  ThemeMode get mode => _mode;

  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  Icons8Style get style => _style;

  set style(Icons8Style style) {
    _style = style;
    notifyListeners();
  }

  Body get body => _body;

  set body(Body body) {
    _body = body;
    notifyListeners();
  }
}
