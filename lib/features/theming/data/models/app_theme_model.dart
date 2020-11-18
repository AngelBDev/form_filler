import 'package:form_filler/features/theming/data/models/color_palette_model.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:meta/meta.dart';

class AppThemeModel extends AppTheme {
  AppThemeModel({
    @required bool isDark,
    @required ColorPaletteModel lightPalette,
    @required ColorPaletteModel darkPalette,
  }) : super(
          isDark: isDark,
          lightPalette: lightPalette,
          darkPalette: darkPalette,
        );
}
