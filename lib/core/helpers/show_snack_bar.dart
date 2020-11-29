import 'package:flutter/material.dart';

void showSnackBar(context, Widget snackBar) {
  Scaffold.of(context).showSnackBar(
    snackBar,
  );
}
