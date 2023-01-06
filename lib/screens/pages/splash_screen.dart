import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/screens/pages/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../di/util/auth_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            const SizedBox(
              height: 32,
            ),
            Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkLogin(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 6));
    if (await AuthManager.isLogin() == true) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
          (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
          ),
          (route) => false);
    }
  }
}
