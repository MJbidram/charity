import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';

class ErrorBox extends StatelessWidget {
  VoidCallback onTap;
  String errorMessage;
  ErrorBox({super.key, required this.errorMessage, required this.onTap});

  get blueDark => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(errorMessage),
        ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: blueDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text('تلاش مجدد'),
        )
      ],
    );
  }
}
