import 'package:flutter/material.dart';

ThemeData get washuLightTheme => ThemeData(
  primarySwatch: const MaterialColor(0xFF68A8C9, <int, Color>{
    50: Color(0x0D68A8C9),
    100: Color(0x1A68A8C9),
    200: Color(0x3368A8C9),
    300: Color(0x4D68A8C9),
    400: Color(0x6668A8C9),
    500: Color(0x8068A8C9),
    600: Color(0x9968A8C9),
    700: Color(0xB368A8C9),
    800: Color(0xCC68A8C9),
    900: Color(0xE668A8C9),
  }),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      maximumSize: Size.infinite,
      minimumSize: const Size(100, 68),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
  ),

);