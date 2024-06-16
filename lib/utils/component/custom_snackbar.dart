import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String contend) {
  final snackBar = SnackBar(
    content: Text(contend),
    backgroundColor: Colors.teal,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: Colors.redAccent,
      onPressed: () {
        //Do whatever you want
      },
    ),
  );
  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
}  