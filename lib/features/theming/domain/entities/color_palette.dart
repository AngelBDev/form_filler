import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorPalette extends Equatable {
  const ColorPalette({
    @required this.isDark,
    @required this.primaryColor,
    @required this.accentColor,
    @required this.backgroundColor,
  });

  final bool isDark;

  final Color primaryColor;
  final Color accentColor;
  final Color backgroundColor;

  @override
  List<Object> get props => [
        primaryColor,
        accentColor,
        backgroundColor,
      ];
}
