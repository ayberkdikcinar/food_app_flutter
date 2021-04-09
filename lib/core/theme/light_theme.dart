import 'package:flutter/material.dart';

import 'ITheme.dart';

class LightTheme extends ITheme {
  static LightTheme? _instance;
  static LightTheme? get instance {
    if (_instance != null) {
      return _instance;
    }
    _instance = LightTheme._init();
    return _instance;
  }

  LightTheme._init();

  final ThemeData _lightTheme = ThemeData.light();

  @override
  ThemeData get data => ThemeData(
      appBarTheme: _lightTheme.appBarTheme.copyWith(backgroundColor: Colors.white70, iconTheme: IconThemeData(color: Colors.blue)),
      backgroundColor: Colors.black,
      accentColor: Colors.blueAccent,
      buttonColor: Colors.black38,
      cardColor: Colors.white70,
      hintColor: Colors.greenAccent,
      hoverColor: Color.fromARGB(255, 231, 195, 17),
      canvasColor: Color.fromARGB(255, 180, 180, 180),
      scaffoldBackgroundColor: Colors.white);
}
