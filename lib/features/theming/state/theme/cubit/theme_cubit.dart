import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({AppTheme appTheme}) : super(ThemeState(theme: appTheme));

  void chageTheme({ThemeOptions theme}) {
/*     final newTheme = themeSwitcher.theme(theme);
    emit(ThemeState(theme: newTheme)); */
  }

  void changeThemeMode() {
    final newTheme = AppTheme(
      isDark: !state.theme.isDark,
      lightPalette: state.theme.lightPalette,
      darkPalette: state.theme.darkPalette,
    );

    emit(ThemeState(theme: newTheme));
  }
}
