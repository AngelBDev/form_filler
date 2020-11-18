import 'package:flutter_test/flutter_test.dart';
import 'package:form_filler/core/themes/themes.dart';
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';

void main() {
  final appThemeModel = themes[ThemeOptions.crimson];

  test('[AppThemeModel] should be a subclass of [AppModel]', () {
    expect(appThemeModel, isA<AppTheme>());
  });
}
