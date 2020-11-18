import 'package:form_filler/core/config/initializers/injection_container_initializer.dart';
import 'package:form_filler/core/config/params/init_app_params.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/state/theme/cubit/theme_cubit.dart';

void initCore() {
  sl.allReady().then(
        (value) => sl.registerFactoryParam<ThemeCubit, AppTheme, void>(
          (theme, __) => ThemeCubit(
            /*     themeSwitcher: sl(), */
            appTheme: theme,
          ),
        ),
      );

  sl.registerFactoryParam<AppTheme, bool, InitAppParams>(
    (isDark, palettes) => AppTheme(
      isDark: isDark,
      lightPalette: palettes.palettes[0],
      darkPalette: palettes.palettes[1] ?? palettes.palettes[0],
    ),
  );
}
