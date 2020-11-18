part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({
    this.theme,
    this.loading,
  });

  final AppTheme theme;
  final bool loading;

  @override
  List<Object> get props => [theme, loading];
}
