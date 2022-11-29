import 'package:charity/constants/constants.dart';
import 'package:charity/screens/pages/charity_page.dart';
import 'package:charity/screens/pages/home_screen.dart';
import 'package:charity/screens/pages/news_list_page.dart';
import 'package:charity/screens/pages/news_page.dart';
import 'package:charity/screens/widget/news_cover.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color.fromARGB(255, 9, 68, 105),
          ),
        ),

        // body: CharityPage(),

        body: MyHomeScreen(),
        bottomNavigationBar: StylishBottomBar(
          items: [
            AnimatedBarItems(
                icon: Icon(
                  Icons.home,
                ),
                selectedColor: blueDark,
                backgroundColor: Colors.amber,
                title: Text('صفحه اصلی')),
            AnimatedBarItems(
                icon: Icon(
                  Icons.person,
                ),
                backgroundColor: Colors.amber,
                selectedColor: blueDark,
                title: Text('حساب کاربری')),
            // BubbleBarItem(icon: Icon(Icons.home), title: Text('Home')),
            // BubbleBarItem(icon: Icon(Icons.add_circle_outline), title: Text('Add')),
            // BubbleBarItem(icon: Icon(Icons.person), title: Text('Profile')),
          ],

          iconSize: 32,
          barAnimation: BarAnimation.blink,
          // iconStyle: IconStyle.animated,
          // iconStyle: IconStyle.simple,
          hasNotch: true,
          fabLocation: StylishBarFabLocation.end,
          opacity: 0.3,
          currentIndex: 0,

          //Bubble bar specific style properties
          //unselectedIconColor: Colors.grey,
          // barStyle: BubbleBarStyle.horizotnal,
          //bubbleFillStyle: BubbleFillStyle.fill,

          onTap: (index) {
            // setState(() {
            //   selected = index;
            // });
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // setState(() {
            //   heart = !heart;
            // });
          },
          backgroundColor: blueDark,
          child: Icon(
            Icons.handshake,
            color: Colors.white,
            size: 40,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
