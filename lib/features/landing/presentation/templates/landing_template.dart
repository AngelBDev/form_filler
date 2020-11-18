import 'package:flutter/material.dart';
import 'package:form_filler/features/landing/presentation/organisms/landing_body.dart';

class LandingTemplate extends StatelessWidget {
  const LandingTemplate({
    Key key,
    this.onPressPrimaryButton,
    this.onPressSecundaryButton,
  }) : super(key: key);

  final void Function() onPressPrimaryButton;
  final void Function() onPressSecundaryButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    final topPadding = MediaQuery.of(context).size.height * .25;
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: LandingBody(
          onPressPrimaryButton: onPressPrimaryButton,
          onPressSecundaryButton: onPressSecundaryButton,
        ),
      ),
    );
  }
}
