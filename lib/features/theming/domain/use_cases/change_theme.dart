import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:form_filler/core/models/error/failures.dart';
import 'package:form_filler/core/models/use_case/use_case.dart';
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/domain/repositories/theme_repository.dart';
import 'package:meta/meta.dart';

class ChangeTheme implements UseCase<AppTheme, ChangeThemeParams> {
  ChangeTheme({@required this.repository});
  ThemeRepository repository;

  @override
  Future<Either<Failure, AppTheme>> call(ChangeThemeParams params) async {
    final themeOptions = params.themeOption;
    final newTheme = repository.changeTheme(themeOption: themeOptions);

    return newTheme;
  }
}

class ChangeThemeParams extends Equatable {
  ChangeThemeParams({@required this.themeOption});
  final ThemeOptions themeOption;

  @override
  List<Object> get props => [themeOption];
}
