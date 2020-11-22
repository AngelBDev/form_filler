import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_filler/core/config/initializers/injection_container_initializer.dart';
import 'package:form_filler/core/config/params/init_app_params.dart';
import 'package:form_filler/core/utils/enviroment.dart';
import 'package:form_filler/features/form_fill/data/repositories/bill_repository_impl.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/state/theme/cubit/theme_cubit.dart';

void initCore() {
  sl.allReady().then(
        (value) => sl.registerFactoryParam<ThemeCubit, AppTheme, void>(
          (theme, __) => ThemeCubit(
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

  sl.registerLazySingleton(
    () => Dio(),
  );

  sl.registerLazySingleton(
    () => Enviroment(
      env: DotEnv().env,
    ),
  );

  sl.registerLazySingleton(
    () => BillRepositoryImpl(
      dio: sl<Dio>(),
      env: sl<Enviroment>(),
    ),
  );
}
