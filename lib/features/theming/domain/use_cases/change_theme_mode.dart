import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:form_filler/core/error/failures.dart';
import 'package:form_filler/core/use_case/use_case.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:meta/meta.dart';

class ChangeThemeMode extends UseCase<AppTheme, ChangeThemeModeParams> {
  @override
  Future<Either<Failure, AppTheme>> call(ChangeThemeModeParams params) async {
    final theme = params.theme;
    final themeIsDarkMode = theme.isDark;
    final updatedTheme = params.theme.copyWith(
      isDark: !themeIsDarkMode,
    );

    return Right(updatedTheme);
  }
}

class ChangeThemeModeParams extends Equatable {
  ChangeThemeModeParams({@required this.theme});
  final AppTheme theme;

  @override
  List<Object> get props => [theme];
}
