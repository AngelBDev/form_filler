import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, Widget snackBar) {
  Scaffold.of(context).showSnackBar(
    snackBar,
  );
}
