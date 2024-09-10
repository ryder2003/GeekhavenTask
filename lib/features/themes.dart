import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.purple,
      secondary: Colors.purpleAccent,
    )
);

ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.black45,
      primary: Colors.purple,
      secondary: Colors.purpleAccent,
    )
);