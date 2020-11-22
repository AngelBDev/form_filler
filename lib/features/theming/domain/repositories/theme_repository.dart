import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:form_filler/core/models/error/failures.dart';
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';

abstract class ThemeRepository {
  const ThemeRepository({@required this.themes});
  final Map<ThemeOptions, AppTheme> themes;

  Either<Failure, AppTheme> changeTheme({@required ThemeOptions themeOption});

  Either<Failure, AppTheme> changeThemeMode({@required AppTheme theme});
}
