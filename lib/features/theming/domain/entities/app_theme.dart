import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:form_filler/features/theming/domain/entities/color_palette.dart';

class AppTheme extends Equatable {
  const AppTheme({
    @required this.isDark,
    @required this.lightPalette,
    this.darkPalette,
  });

  final bool isDark;
  final ColorPalette darkPalette;
  final ColorPalette lightPalette;

  ColorPalette get colorPalette =>
      isDark ? (darkPalette ?? lightPalette) : lightPalette;

  ThemeData get themeData {
    final textTheme = (isDark
        ? ThemeData.dark().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Colors.brown,
              ),
              subtitle1: TextStyle(
                color: Colors.brown,
              ),
            )
        : ThemeData.light().textTheme);

    final textColor = textTheme.bodyText1.color;

    final colorScheme = ColorScheme(
      primary: colorPalette.primaryColor,
      primaryVariant: colorPalette.primaryColor,
      secondary: colorPalette.accentColor,
      secondaryVariant: colorPalette.accentColor,
      surface: colorPalette.backgroundColor,
      background: colorPalette.backgroundColor,
      error: Colors.red.shade400,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textColor,
      onBackground: textColor,
      onError: Colors.white,
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    final labelStyle = TextStyle(
      color: Colors.brown,
    );

    final hintStyle = TextStyle(
      color: Colors.brown,
    );

    final inputDecorationTheme = InputDecorationTheme(
      focusColor: Colors.brown,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      fillColor: Colors.brown,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.brown,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.brown,
        ),
      ),
    );

    final themeData =
        ThemeData.from(colorScheme: colorScheme, textTheme: textTheme).copyWith(
      buttonColor: colorPalette.accentColor,
      cursorColor: colorPalette.accentColor,
      highlightColor: colorPalette.accentColor,
      toggleableActiveColor: colorPalette.accentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      inputDecorationTheme: inputDecorationTheme,
    );

    return themeData;
  }

  AppTheme copyWith({
    bool isDark,
    ColorPalette darkPalette,
    ColorPalette lightPalette,
  }) {
    return AppTheme(
      isDark: isDark ?? this.isDark,
      darkPalette: darkPalette ?? this.darkPalette,
      lightPalette: lightPalette ?? this.lightPalette,
    );
  }

  @override
  List<Object> get props => [isDark, colorPalette];
}
