import 'package:charity/constants/constants.dart';
import 'package:flutter/material.dart';

class HadisContainer extends StatelessWidget {
  const HadisContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, top: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 175,
          decoration: BoxDecoration(
            gradient: blueGradient,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text('حدیث'),
          ),
        ),
      ),
    );
  }
}
