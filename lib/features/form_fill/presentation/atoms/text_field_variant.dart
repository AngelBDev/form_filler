import 'package:flutter/material.dart';

class TextFieldVariant extends StatelessWidget {
  const TextFieldVariant(
      {Key key, this.hintText, this.controller, this.keyboardType})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
