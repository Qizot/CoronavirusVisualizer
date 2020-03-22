


import 'package:flutter/material.dart';

void showDefaultSnackbar(context, {String message,  Duration duration = const Duration(seconds:  2), Color backgroundColor, TextStyle textStyle}) {
  Scaffold.of(context).hideCurrentSnackBar();
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: backgroundColor,
    content: Text(message, style: textStyle),
    duration: duration,
  ));
}

void showSuccessSnackbar(context, {String message, Duration duration = const Duration(seconds:  2)}) {
  showDefaultSnackbar(context, message: message, duration: duration, backgroundColor: Colors.green, textStyle: TextStyle(color: Colors.white));
}

void showErrorSnackbar(context, {String message, Duration duration = const Duration(seconds:  2)}) {
  showDefaultSnackbar(context, message: message, duration: duration, backgroundColor: Colors.red, textStyle: TextStyle(color: Colors.white));
}