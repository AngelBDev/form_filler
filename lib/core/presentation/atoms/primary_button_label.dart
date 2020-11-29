import 'package:flutter/material.dart';

class PrimaryButtonLabel extends StatelessWidget {
  const PrimaryButtonLabel({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Color.fromRGBO(55, 55, 55, .7),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
