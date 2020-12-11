import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, Widget snackBar) {
  ScaffoldMessenger.of(context).showSnackBar(
    snackBar,
  );
}
