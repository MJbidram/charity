import 'package:charity/bloc/splash_screen_bloc/splash_bloc.dart';
import 'package:charity/bloc/splash_screen_bloc/splash_state.dart';
import 'package:charity/screens/pages/main_screen.dart';
import 'package:charity/screens/pages/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/splash_screen_bloc/splash_event.dart';
import '../../constants/constants.dart';

import '../widget/spin_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashBloc>(context).add(CheckConnectionEvent());
    super.initState();
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
              child: Image.asset('assets/images/logo2.png'),
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
                child: BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    if (state is ConnectionStates) {
                      if (state.isConnect) {
                        context.read<SplashBloc>().add(CheckLoginEvent());
                        return const MySpinKit();
                      } else {
                        return Column(
                          children: [
                            Text('خطا در ارتباط با اینترنت',
                                style: Theme.of(context).textTheme.headline2),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: blueLight),
                              onPressed: () {
                                context
                                    .read<SplashBloc>()
                                    .add(CheckConnectionEvent());
                              },
                              child: const Text('تلاش مجدد'),
                            ),
                          ],
                        );
                      }
                    }
                    if (state is SpalshLoadingState) {
                      return const MySpinKit();
                    }
                    if (state is LoginState) {
                      if (state.isLogin) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainScreen(),
                              ),
                              (route) => false);
                        });

                        return const MySpinKit();
                      } else {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ),
                              (route) => false);
                        });

                        return const MySpinKit();
                      }
                    } else {
                      return const Text('خطا');
                    }
                  },
                )
                // const CircularProgressIndicator(),
                ),
          ],
        ),
      ),
    );
  }
}
