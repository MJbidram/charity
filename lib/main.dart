import 'package:charity/constants/constants.dart';
import 'package:charity/screens/pages/home_screen.dart';

import 'package:charity/screens/pages/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"),

      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 9, 68, 105),
          ),
        ),

        // body: CharityPage(),

        body: MainScreen(),
      ),
      // builder: (context, child) {
      //   return Directionality(
      //     textDirection: TextDirection.rtl,
      //     child:
      //   );
      // },
      theme: ThemeData(
        fontFamily: 'VB',
        backgroundColor: Colors.grey[200],
        textTheme: TextTheme(
          headline1: TextStyle(
              fontFamily: 'VB',
              fontSize: 16,
              // fontWeight: FontWeight.w800,
              color: white),
          headline2: TextStyle(
              fontFamily: 'VM',
              fontSize: 16,
              // fontWeight: FontWeight.w600,
              color: white),
          headline3: TextStyle(
              fontFamily: 'VL',
              fontSize: 16,
              // fontWeight: FontWeight.w400,
              color: white),
          headline4: TextStyle(
              fontFamily: 'VL',
              fontSize: 14,
              // fontWeight: FontWeight.w400,
              color: white),
          headline5: TextStyle(
              fontFamily: 'VB',
              fontSize: 16,
              // fontWeight: FontWeight.w400,
              color: blueDark),
          headline6: TextStyle(
              fontFamily: 'VL',
              fontSize: 16,
              // fontWeight: FontWeight.w400,
              color: blueDark),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
