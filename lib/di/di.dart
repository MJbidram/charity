import 'package:charity/constants/constants.dart';
import 'package:charity/data/datasource/authentication_dataSource.dart';
import 'package:charity/data/repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  //component

  locator
      .registerSingleton<Dio>(Dio(BaseOptions(baseUrl: ApiAddress.baseApiUrl)));

  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
// datasourses
  locator
      .registerFactory<IAuthenticationDataSurce>(() => AuthenticationRemote());

  //repository

  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());
}
