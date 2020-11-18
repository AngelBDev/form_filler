import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_filler/core/themes/themes.dart' as _theme_initializer;
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/domain/use_cases/change_theme_mode.dart';

void main() {
  ChangeThemeMode useCase;
  Map<ThemeOptions, AppTheme> themes;
  ThemeOptions themeOption;
  AppTheme theme;
  bool isThemeDarkMode;
  AppTheme updatedTheme;

  setUp(() {
    useCase = ChangeThemeMode();
    themes = _theme_initializer.themesMock;
    themeOption = ThemeOptions.crimson;
    theme = themes[themeOption];
    isThemeDarkMode = theme.isDark;
    updatedTheme = theme.copyWith(isDark: !isThemeDarkMode);
  });

  test('should return the theme with the mode inverted', () async {
    // arrange

    final result = await useCase(
      ChangeThemeModeParams(theme: theme),
    );

    bool updatedIsThemeDarkMode;

    result.fold(
      (l) => updatedIsThemeDarkMode = isThemeDarkMode,
      (r) => updatedIsThemeDarkMode = r.isDark,
    );

    // assert

    expect(result, Right(updatedTheme));
    expect(updatedIsThemeDarkMode, isNot(equals(isThemeDarkMode)));
  });
}
