import 'package:flutter/material.dart';
import 'package:form_filler/core/presentation/atoms/neumorphic_container.dart';

class TextFieldVariant extends StatelessWidget {
  const TextFieldVariant(
      {Key key, this.hintText, this.controller, this.keyboardType})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      primaryColor: Theme.of(context).accentColor,
      isDefaultContainer: true,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: TextField(
          cursorColor: Colors.white,
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
