import 'package:flutter/material.dart';

final ColorScheme _colorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.light);
final ColorScheme _darkColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.dark);

final ThemeData themeData = ThemeData(
  colorScheme: _colorScheme,
);

final ThemeData darkThemeData = ThemeData(
  colorScheme: _darkColorScheme,
);
