import 'package:flutter/cupertino.dart';
import 'package:form_filler/features/theming/domain/entities/color_palette.dart';
import 'package:meta/meta.dart';

class ColorPaletteModel extends ColorPalette {
  ColorPaletteModel({
    @required bool isDark,
    @required Color primaryColor,
    @required Color accentColor,
    @required Color backgroundColor,
  }) : super(
          isDark: isDark,
          primaryColor: primaryColor,
          accentColor: accentColor,
          backgroundColor: backgroundColor,
        );
}
