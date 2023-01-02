import 'dart:io';
import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/data/repository/authentication_repository.dart';
import 'package:charity/di/di.dart';

import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/screens/pages/signup_screen.dart';
import 'package:charity/util/auth_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  await getItInit();
  await Hive.initFlutter();
  var box = await Hive.openBox('information');

  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => HomeBloc(),
    ),
    BlocProvider(
      create: (context) => NewsBloc(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = MainScreen();

  // var box = Hive.box('information');
  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    if (AuthManager.isLogin() == true) {
      page = MainScreen();
    } else {
      page = SignUpScreen();
    }
  }

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
      home: page,
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                var either = await AuthenticationRepository()
                    .login('09131111114', '123456781', 'android');

                either.fold((erroreMessage) {
                  erroreMessage?.forEach((element) {
                    if (element != null) if (element.isNotEmpty)
                      print(element);
                    else
                      (print('خطای ناشناخته'));
                  });
                }, (successMessage) => print(successMessage));
                final bool islogedin = await AuthManager.isLogin();
                print('fffff :: ${islogedin}');
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () async {
                AuthManager.logout();
                final bool islogedin = await AuthManager.isLogin();
                print('${islogedin}');
              },
              child: Text('logout'),
            ),
            ElevatedButton(
              onPressed: () async {
                var either = await AuthenticationRepository().register(
                  'mjb',
                  '09132211113',
                  'mjb322@gmail.com',
                  'deviceName',
                  '123456738',
                  '123456738',
                );
                either.fold((erroreMessage) {
                  erroreMessage?.forEach((element) {
                    if (element!.isNotEmpty) print(element);
                  });
                }, (successMessage) => print(successMessage));
                final bool islogedin = await AuthManager.isLogin();
                print('fffff :: ${islogedin}');
              },
              child: Text('register'),
            ),
          ],
        )),
      ),
    );
  }
}
