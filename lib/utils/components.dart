import 'package:flutter/material.dart';

void customScaffoldMessage(BuildContext context, String message,
    {Duration? duration}) {
  var snackBar = SnackBar(
    content: Text(message),
    duration: duration ?? const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
