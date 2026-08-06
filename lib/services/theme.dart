import 'package:flutter/material.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(actionsPadding: EdgeInsets.only(right: 12)),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
        brightness: Brightness.dark,
      ).onSurface.withValues(alpha: 0.3),
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    backgroundColor: Colors.deepPurple,
    actionTextColor: Colors.white,
    contentTextStyle: TextStyle(color: Colors.white),
  ),
);
