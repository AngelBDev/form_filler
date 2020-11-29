import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_filler/core/config/initializers/dependencies/injection_container_initializer.dart';
import 'package:form_filler/core/config/params/init_app_params.dart';
import 'package:form_filler/core/utils/enviroment.dart';
import 'package:form_filler/features/form_fill/data/repositories/bill_repository_impl.dart';
import 'package:form_filler/features/form_fill/data/repositories/form_606_repository_impl.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/state/theme/cubit/theme_cubit.dart';

void initCore() {
  locator.allReady().then(
    (value) {
      locator.registerFactoryParam<ThemeCubit, AppTheme, void>(
        (theme, __) => ThemeCubit(
          appTheme: theme,
        ),
      );
    },
  );

  locator.registerFactoryParam<AppTheme, bool, InitAppParams>(
    (isDark, palettes) => AppTheme(
      isDark: isDark,
      lightPalette: palettes.palettes[0],
      darkPalette: palettes.palettes[1] ?? palettes.palettes[0],
    ),
  );

  locator.registerSingleton(
    () => Dio(),
  );

  locator.registerSingleton(
    () => Enviroment(
      env: DotEnv().env,
    ),
  );

  locator.registerSingleton(
    () => BillRepositoryImpl(
      dio: locator<Dio>(),
      env: locator<Enviroment>(),
    ),
  );

  locator.registerSingleton(
    () => Form606RepositoryImpl(
      dio: locator<Dio>(),
      env: locator<Enviroment>(),
    ),
  );
}
