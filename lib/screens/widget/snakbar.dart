import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
