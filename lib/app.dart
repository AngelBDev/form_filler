import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_filler/core/config/initializers/state/providers.dart';
import 'package:form_filler/core/routes/routes.dart';
import 'package:form_filler/core/themes/themes.dart';
import 'package:form_filler/features/landing/presentation/pages/landing_screen.dart';
import 'package:form_filler/features/theming/domain/data_structures/theme_enum.dart';
import 'package:form_filler/features/theming/state/theme/cubit/theme_cubit.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final initialTheme = themes[ThemeOptions.crimson];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildProviders(context);
  }

  Widget _buildProviders(BuildContext context) {
    return InitialProviders(
      initialTheme: initialTheme,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return _buildMaterialApp(state.theme.themeData);
        },
      ),
    );
  }

  MaterialApp _buildMaterialApp(ThemeData theme) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: LandingScreen(),
      routes: routes,
    );
  }
}
