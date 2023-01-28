import 'package:charity/constants/constants.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MySpinKit extends StatelessWidget {
  const MySpinKit({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: Colors.blueAccent,
      size: 30,
    );
  }
}
