import 'package:flutter/material.dart';

mySnackBar(BuildContext context, String text, {required VoidCallback onTap}) {
  final snackBar = SnackBar(
    content: Text(text),
    duration: Duration(seconds: 20),
    action: SnackBarAction(
      label: 'تلاش مجدد',
      onPressed: onTap,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
