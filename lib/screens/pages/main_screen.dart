import 'package:charity/bloc/charity_bloc/chrity_bloc.dart';
import 'package:charity/bloc/damand_bloc/damand_bloc.dart';
import 'package:charity/bloc/home_bloc/home_bloc.dart';
import 'package:charity/bloc/news_page_bloc/news_page_block.dart';
import 'package:charity/bloc/profile_bloc/profle_bloc.dart';
import 'package:charity/constants/constants.dart';
import 'package:charity/screens/pages/charity_screen.dart';
import 'package:charity/screens/pages/damand_screen.dart';
import 'package:charity/screens/pages/home_screen.dart';
import 'package:charity/screens/pages/news_list_screen.dart';
import 'package:charity/screens/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  static bool isPooyeshSelected = false;
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _selectedBottomNavigationItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: StylishBottomBar(
            padding: const EdgeInsets.only(top: 4),

            items: [
              AnimatedBarItems(
                  icon: const Icon(
                    Icons.home,
                  ),
                  selectedColor: blueDark,
                  backgroundColor: Colors.amber,
                  title: const Text('صفحه اصلی')),
              AnimatedBarItems(
                  icon: const Icon(
                    Icons.waving_hand_rounded,
                  ),
                  backgroundColor: Colors.amber,
                  selectedColor: blueDark,
                  title: const Text('درخواست')),
              // BubbleBarItem(icon: Icon(Icons.home), title: Text('Home')),
              // BubbleBarItem(icon: Icon(Icons.add_circle_outline), title: Text('Add')),
              // BubbleBarItem(icon: Icon(Icons.person), title: Text('Profile')),
              AnimatedBarItems(
                  icon: const Icon(
                    Icons.feed,
                  ),
                  backgroundColor: Colors.amber,
                  selectedColor: blueDark,
                  title: const Text('اخبار')),
              AnimatedBarItems(
                  icon: const Icon(
                    Icons.person,
                  ),
                  backgroundColor: Colors.amber,
                  selectedColor: blueDark,
                  title: const Text('حساب کاربری')),
            ],

            iconSize: 32,
            barAnimation: BarAnimation.blink,
            // iconStyle: IconStyle.animated,
            // iconStyle: IconStyle.simple,
            hasNotch: true,

            fabLocation: StylishBarFabLocation.center,
            opacity: 0.3,
            currentIndex: _selectedBottomNavigationItem,

            //Bubble bar specific style properties
            //unselectedIconColor: Colors.grey,
            // barStyle: BubbleBarStyle.horizotnal,
            //bubbleFillStyle: BubbleFillStyle.fill,

            onTap: (int? index) {
              setState(() {
                _selectedBottomNavigationItem = index!;
              });
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return BlocProvider(
                create: (context) => CharityBloc(),
                child: CharityPage(id: 0, title: 'null'),
              );
            },
          ));
        },
        backgroundColor: blueDark,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: blueGradient,
              boxShadow: [
                BoxShadow(
                  color: white,
                  blurRadius: 8,
                  spreadRadius: 0.1,
                )
              ]),
          child: const Icon(
            Icons.handshake,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: _getPages(),
    );
  }

  Widget _getPages() {
    return IndexedStack(
      index: _selectedBottomNavigationItem,
      children: [
        BlocProvider(
            create: (context) => HomeBloc(), child: const MyHomeScreen()),
        BlocProvider(
          create: (context) => DamandBloc(),
          child: const DamandScreen(),
        ),
        BlocProvider(create: (context) => NewsBloc(), child: NewsListPage()),
        BlocProvider(
            create: (context) => ProfielBloc(), child: const ProfileScreen()),
      ],
    );
  }
}
