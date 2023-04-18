import 'package:charity/bloc/splash_screen_bloc/splash_bloc.dart';
import 'package:dartz/dartz.dart';

abstract class SplashState {}

class SplashInitState extends SplashState {}

class ConnectionStates extends SplashState {
  bool isConnect;
  ConnectionStates(this.isConnect);
}

class SpalshLoadingState extends SplashState {}

class AvalableState extends SplashState {}

class LoginState extends SplashState {
  bool isLogin;
  LoginState(this.isLogin);
}

class UnAvailableState extends SplashState {
  Either<String, String> unMessage;

  UnAvailableState(this.unMessage);
}
