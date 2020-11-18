import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/color_palette.dart';

class InitAppParams {
  InitAppParams({
    this.activeTheme,
    this.palettes,
  });

  final ThemeOptions activeTheme;
  final List<ColorPalette> palettes;
}
