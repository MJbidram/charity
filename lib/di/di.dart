import 'package:charity/constants/constants.dart';
import 'package:charity/data/datasource/authentication_dataSource.dart';
import 'package:charity/data/datasource/charity_datasource.dart';
import 'package:charity/data/datasource/factors_datasource.dart';
import 'package:charity/data/datasource/home_datasource.dart';
import 'package:charity/data/repository/authentication_repository.dart';
import 'package:charity/data/repository/factors_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../data/datasource/payment_datasource.dart';
import '../data/repository/charity_repository.dart';
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

  locator.registerFactory<CharityDatasource>(() => CharityRemote());

  locator.registerFactory<IFactorsdatasourse>(() => FactorsDatasourse());

  locator.registerFactory<IPaymentOperation>(() => PaymentOperation());

  //repository

  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());

  locator.registerFactory<MyCharityRepository>(() => CharityRepository());

  locator.registerFactory<IpaymentRepository>(() => PaymentRepository());

  locator.registerFactory<IFactorsRepositorys>(() => FactorsRepositorys());
}
