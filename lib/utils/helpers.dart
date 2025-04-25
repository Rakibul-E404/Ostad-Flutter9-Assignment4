import 'package:flutter/material.dart';

class Helpers {
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  static String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static void dismissKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}