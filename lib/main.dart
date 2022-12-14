import 'dart:io';

import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:charity/bloc/home_bloc/home_state.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/repositories/repositories.dart';
import 'package:charity/screens/pages/charity_screen.dart';
import 'package:charity/screens/pages/home_screen.dart';

import 'package:charity/screens/pages/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main(List<String> args) {
  HttpOverrides.global = MyHttpOverrides();
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

      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => Repositories(),
          )
        ],
        child: MainScreen(),
      ),

      // Scaffold(
      //   appBar: AppBar(
      //     toolbarHeight: 0,
      //     elevation: 0,
      //     systemOverlayStyle: const SystemUiOverlayStyle(
      //       statusBarColor: Color.fromARGB(255, 9, 68, 105),
      //     ),
      //   ),

      //   // body: CharityPage(),

      //   body: TestBloc(),
      // ),

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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class HomeTestScreen extends StatelessWidget {
  const HomeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        RepositoryProvider.of<Repositories>(context),
      )..add(LoadApiEvent()),
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeLoadedState) {
              return Column(
                children: [
                  Text(state.arabicText),
                  Text(state.farsiText),
                  Text(state.teller),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
