import 'dart:async';
import 'dart:io';
import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/di/di.dart';
import 'package:charity/screens/pages/login_screen.dart';
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
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => NewsBloc(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  static ValueNotifier<int> pageValuNotifire = ValueNotifier(0);
  MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // var box = Hive.box('information');
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    checkLogin();
  }

  int _selectedPage = 0;
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
      home: ValueListenableBuilder(
        valueListenable: MyApp.pageValuNotifire,
        builder: (context, value, child) {
          switch (value) {
            case 0:
              _selectedPage = 0;

              break;
            case 1:
              _selectedPage = 1;

              break;

            case 2:
              _selectedPage = 2;

              break;
            case 3:
              _selectedPage = 3;
          }
          return getPages();
        },
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

  Widget getPages() {
    return IndexedStack(
      index: _selectedPage,
      children: const [
        LoadingPage(),
        MainScreen(),
        SignUpScreen(),
        LoginScreen(),
      ],
    );
  }

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 10));
    if (await AuthManager.isLogin() == true) {
      setState(() {
        MyApp.pageValuNotifire.value = 1;
        // MyApp.pageValuNotifire.notifyListeners();
      });
    } else {
      setState(() {
        MyApp.pageValuNotifire.value = 2;
        // MyApp.pageValuNotifire.notifyListeners();
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    MyApp.pageValuNotifire.dispose();
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

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: blueGradient),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
            width: 80,
            child: Image.asset('assets/images/logo.png'),
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            longName,
            style: TextStyle(color: white, fontSize: 16, fontFamily: 'VB'),
          ),
          Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
