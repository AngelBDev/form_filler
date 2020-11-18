import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_filler/core/themes/themes.dart' as _theme_initializer;
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/domain/repositories/theme_repository.dart';
import 'package:form_filler/features/theming/domain/use_cases/change_theme.dart';
import 'package:mockito/mockito.dart';

class MockThemeRepository extends Mock implements ThemeRepository {
  MockThemeRepository({this.themes});

  @override
  final Map<ThemeOptions, AppTheme> themes;
}

void main() {
  MockThemeRepository mockThemeRepository;
  ChangeTheme useCase;
  Map<ThemeOptions, AppTheme> themes;
  ThemeOptions themeOption;
  AppTheme newTheme;

  setUp(() {
    mockThemeRepository = MockThemeRepository(themes: themes);
    useCase = ChangeTheme(repository: mockThemeRepository);
    themes = _theme_initializer.themesMock;
    themeOption = ThemeOptions.crimson;
    newTheme = themes[themeOption];
  });

  test('should return the theme that matches the theme option', () async {
    // arrange
    when(
      mockThemeRepository.changeTheme(
        themeOption: argThat(isNotNull, named: 'themeOption'),
      ),
    ).thenAnswer((_) => Right(newTheme));

    final result = await useCase(
      ChangeThemeParams(themeOption: ThemeOptions.crimson),
    );

    // assert
    expect(result, Right(newTheme));
    verify(mockThemeRepository.changeTheme(themeOption: themeOption));
    verifyNoMoreInteractions(mockThemeRepository);
  });
}
