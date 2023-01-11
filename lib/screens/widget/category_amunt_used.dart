import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/html_parser.dart';

class AmountUsed extends StatelessWidget {
  final String amountText;
  final String amountValue;
  final VoidCallback? onTap;
  AmountUsed(
      {super.key,
      required this.amountText,
      required this.amountValue,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 25,
            margin: const EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Center(
                  child: Text(
                amountText,
                style: const TextStyle(fontFamily: 'VM', fontSize: 12),
              )),
            ),
          ),
        ),
      ],
    );
  }
}
