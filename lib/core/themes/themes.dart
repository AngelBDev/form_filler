import 'package:flutter/material.dart';
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/domain/entities/color_palette.dart';

final Map<ThemeOptions, AppTheme> themesMock = {
  ThemeOptions.crimson: AppTheme(
    isDark: false,
    lightPalette: ColorPalette(
      isDark: false,
      primaryColor: Colors.red,
      accentColor: Colors.pink,
      backgroundColor: Colors.white,
    ),
  )
};

final Map<ThemeOptions, AppTheme> themes = {
  ThemeOptions.crimson: AppTheme(
    isDark: true,
    lightPalette: ColorPalette(
      isDark: false,
      accentColor: Colors.red.shade200,
      primaryColor: Colors.red.shade200,
      backgroundColor: Colors.white,
    ),
    darkPalette: ColorPalette(
      isDark: true,
      /*      accentColor: Colors.blueGrey, */
      primaryColor: Color(0xfffdc28d),
      backgroundColor: Color(0xfffdc28d),
      /*     isDark: true, */
      accentColor: Color.fromRGBO(50, 50, 50, 1),
/*       primaryColor: Color.fromRGBO(200, 200, 200, 1),
      backgroundColor: Color.fromRGBO(200, 200, 200, 1), */
    ),
  ),
  ThemeOptions.green: AppTheme(
    isDark: true,
    lightPalette: ColorPalette(
      isDark: false,
      accentColor: Colors.brown,
      primaryColor: Colors.brown,
      backgroundColor: Colors.white,
    ),
    darkPalette: ColorPalette(
      isDark: true,
      accentColor: Colors.green.shade800,
      primaryColor: Colors.green.shade700,
      backgroundColor: Colors.black,
    ),
  ),
};
