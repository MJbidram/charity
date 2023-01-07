import 'package:charity/constants/constants.dart';
import 'package:charity/data/datasource/authentication_dataSource.dart';
import 'package:charity/data/datasource/charity_datasource.dart';
import 'package:charity/data/datasource/home_datasource.dart';
import 'package:charity/data/repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../data/datasource/payment_datasource.dart';
import '../data/repository/payment_repository.dart';

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

  // get Charity Types

  locator.registerFactory<CharityDatasource>(() => CharityRemote());

  // get Home data
  // locator.registerFactory<HomeDataSource>(() => HomeDataRemote());

  //payment
  locator.registerFactory<IPaymentOperation>(() => PaymentOperation());
  locator.registerFactory<IpaymentRepository>(() => PaymentRepository());
}
