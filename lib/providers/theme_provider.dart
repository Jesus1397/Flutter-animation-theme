import 'package:flutter/material.dart';

class ThemeChangeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeChangeProvider(this._themeData);

  get getTheme => _themeData;
  set setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}