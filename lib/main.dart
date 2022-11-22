import 'package:carousel_slider/carousel_slider.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/test_screens/appbar_screen_home.dart';
import 'package:charity/test_screens/features_screen-test.dart';
import 'package:charity/test_screens/hadis_screen_test.dart';
import 'package:charity/test_screens/image_slider_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xff457b9d),
          ),
        ),
        body: AppbarScreen(),
      ),
    );
  }
}
