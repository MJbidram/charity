import 'package:charity/bloc/splash_screen_bloc/splash_event.dart';
import 'package:charity/bloc/splash_screen_bloc/splash_state.dart';
import 'package:charity/di/di.dart';
import 'package:charity/util/auth_manager.dart';
import 'package:dartz/dartz.dart';

import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:dio/dio.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitState()) {
    on<CheckConnectionEvent>((event, emit) async {
      emit(SpalshLoadingState());
      var result = await DataConnectionChecker().hasConnection;
      emit(ConnectionStates(result));
    });
    on<CheckAvailableEvent>((event, emit) async {
      Future<Either<String, String>> checkAvalable() async {
        final Dio _dio = locator.get();
        try {
          var response = await _dio.get('');
          return right('خیریه در دسترس است');
        } on DioError catch (e) {
          if (e.response!.statusCode == 403) {
            return left(e.response!.data['message']);
          } else {
            return left('خطا در ارتباط با سرور');
          }
        }
      }

      var response = await checkAvalable();
      emit(UnAvailableState(response));
    });
    on<CheckLoginEvent>((event, emit) async {
      emit(SpalshLoadingState());

      var isLogin = await AuthManager.isLogin();
      Future.delayed(Duration(seconds: 2));
      emit(LoginState(isLogin));
    });
  }
}
