import 'package:flutter/material.dart';

SnackBar defaultSnackBar({
  SnackBarType type,
  String message,
}) {
  return SnackBar(
    backgroundColor: _getColor(type),
    content: _buildMessage(message),
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  );
}

Text _buildMessage(String message) => Text(
      message,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );

Color _getColor(SnackBarType type) {
  if (type == SnackBarType.error) return Colors.red;

  if (type == SnackBarType.success) return Colors.green;

  if (type == SnackBarType.warning) return Colors.yellow[600];

  return Colors.grey;
}

enum SnackBarType {
  error,
  success,
  warning,
}
