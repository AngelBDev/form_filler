import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/core/config/initializers/initializer.dart';
import 'package:form_filler/core/config/initializers/injection_container_initializer.dart';
import 'package:form_filler/core/config/params/init_app_params.dart';
import 'package:form_filler/core/routes/routes.dart';
import 'package:form_filler/core/themes/themes.dart';
import 'package:form_filler/features/landing/presentation/pages/landing_screen.dart';
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/domain/entities/app_theme.dart';
import 'package:form_filler/features/theming/state/theme/cubit/theme_cubit.dart';

void main() {
  initMain();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeCubit _themeState;
  AppTheme initialTheme;

  @override
  void initState() {
    super.initState();
    _initMembers();
    initApp(params: InitAppParams(activeTheme: ThemeOptions.crimson));
  }

  @override
  void dispose() {
    _themeState.close();
    super.dispose();
  }

  void _initMembers() {
    initialTheme = themes[ThemeOptions.crimson];
    _themeState = sl.get<ThemeCubit>(param1: initialTheme);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>.value(
      value: _themeState,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: _builder,
      ),
    );
  }

  Widget _builder(BuildContext context, ThemeState state) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: state.theme?.themeData,
      home: LandingScreen(),
      routes: routes,
    );
  }
}
