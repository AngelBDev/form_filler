import 'package:flutter/material.dart';
import 'package:form_filler/features/form_fill/presentation/pages/form_fill_screen.dart';
import 'package:form_filler/features/landing/presentation/templates/landing_template.dart';

class LandingScreen extends StatelessWidget {
  static const route = '/';
  const LandingScreen({Key key}) : super(key: key);

  void _navigateToHistoryScreen(BuildContext context) {
    Navigator.of(context).pushNamed('history');
  }

  void _navigateToFillFormScreen(BuildContext context) {
    Navigator.of(context).pushNamed(FormFillScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return LandingTemplate(
      onPressPrimaryButton: () => _navigateToFillFormScreen(context),
      onPressSecundaryButton: () => _navigateToHistoryScreen(context),
    );
  }
}
