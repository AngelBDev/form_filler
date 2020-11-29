import 'package:flutter/material.dart';
import 'package:form_filler/core/presentation/atoms/logo.dart';
import 'package:form_filler/core/presentation/atoms/primary_button.dart';
import 'package:form_filler/core/presentation/atoms/primary_button_label.dart';
import 'package:form_filler/features/landing/presentation/molecules/landing_form.dart';

class LandingBody extends StatelessWidget {
  const LandingBody({
    Key key,
    this.onPressPrimaryButton,
    this.onPressSecundaryButton,
  }) : super(key: key);

  final void Function() onPressPrimaryButton;
  final void Function() onPressSecundaryButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Logo(),
          SizedBox(
            height: 50,
          ),
          LandingForm(
            primaryButton: PrimaryButton(
              child: PrimaryButtonLabel(text: 'Llenar Formulario'),
              onPressed: onPressPrimaryButton?.call,
            ),
          ),
        ],
      ),
    );
  }
}
