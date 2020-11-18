import 'package:flutter/material.dart';

class LandingForm extends StatelessWidget {
  const LandingForm({
    Key key,
    this.primaryButton,
    this.secundaryButton,
  }) : super(key: key);

  final Widget primaryButton;

  final Widget secundaryButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (secundaryButton != null) secundaryButton,
          SizedBox(
            width: 16,
          ),
          if (primaryButton != null) primaryButton,
        ],
      ),
    );
  }
}
