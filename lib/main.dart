import 'dart:io';
import 'package:charity/bloc/charity_bloc/chrity_bloc.dart';
import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/screens/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'bloc/splash_screen_bloc/splash_bloc.dart';
import 'models/charity_model.dart';

void main(List<String> args) async {
  await getItInit();
  await Hive.initFlutter();
  var box = await Hive.openBox('information');
  Hive.registerAdapter(CharityModelFirstAdapter());
  Hive.registerAdapter(CharityModelSecandAdapter());
  await Hive.openBox<CharityModelSecand>('ModelSecand');
  await Hive.openBox<CharityModelFirst>('ModelFirst');
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => NewsBloc(),
        ),
        BlocProvider(
          create: (context) => CharityBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // var box = Hive.box('information');
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"),
      home: BlocProvider(
        create: (context) => SplashBloc(),
        child: const SplashScreen(),
      ),
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

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
