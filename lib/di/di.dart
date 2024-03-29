import 'package:charity/constants/constants.dart';
import 'package:charity/data/datasource/aboutus_datasource.dart';
import 'package:charity/data/datasource/authentication_dataSource.dart';
import 'package:charity/data/datasource/charity_datasource.dart';
import 'package:charity/data/datasource/creat_order_datasource.dart';
import 'package:charity/data/datasource/demand_datasource.dart';
import 'package:charity/data/datasource/factors_datasource.dart';
import 'package:charity/data/datasource/home_datasource.dart';
import 'package:charity/data/datasource/marasemat_datasource.dart';
import 'package:charity/data/datasource/profile_datasource.dart';
import 'package:charity/data/datasource/user_orders_datasorce.dart';
import 'package:charity/data/datasource/wearth_tarh_datasource.dart';
import 'package:charity/data/datasource/wearth_type_datasource.dart';
import 'package:charity/data/repository/authentication_repository.dart';
import 'package:charity/data/repository/creat_order_repository.dart';
import 'package:charity/data/repository/factors_repository.dart';
import 'package:charity/data/repository/home_data_repository.dart';
import 'package:charity/data/repository/marasemat_repository.dart';
import 'package:charity/data/repository/profile_repository.dart';
import 'package:charity/data/repository/user_orders_repository.dart';
import 'package:charity/data/repository/wearth_tarh_repository.dart';
import 'package:charity/data/repository/wearth_type_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../data/datasource/details_of_slider_datasource.dart';
import '../data/datasource/payment_datasource.dart';
import '../data/repository/aboutus_repository.dart';
import '../data/repository/charity_repository.dart';
import '../data/repository/damand_repository.dart';
import '../data/repository/details_of_slider_repository.dart';
import '../data/repository/payment_repository.dart';

var locator = GetIt.instance;

Future<void> getItInit() async {
  //component

  locator
      .registerSingleton<Dio>(Dio(BaseOptions(baseUrl: ApiAddress.baseApiUrl)));

  locator.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
// datasourses
  locator.registerFactory<HomeDataSource>(() => HomeDataRemote());
  locator
      .registerFactory<IAuthenticationDataSurce>(() => AuthenticationRemote());

  locator.registerFactory<CharityDatasource>(() => CharityRemote());

  locator.registerFactory<IFactorsdatasourse>(() => FactorsDatasourse());

  locator.registerFactory<IPaymentOperation>(() => PaymentOperation());

  locator.registerFactory<DetailsOfSlidersDataSourse>(
      () => DetailsOfSlidersRemote());

  locator.registerFactory<IDamandDateasource>(() => DamandRemote());

  locator.registerFactory<ProfileDataSource>(() => ProfileRemote());

  locator.registerFactory<AboutUsDataSource>(() => AboutUsRemot());
  locator.registerFactory<IMarasematDataSource>(() => MarasematRemote());
  locator.registerFactory<IWearthTypeDataSource>(() => WearthTypeRemote());
  locator.registerFactory<IWearthTarhDataSource>(() => WearthTarhRemote());
  locator.registerFactory<ICreatOrderDatasource>(() => CreatOrderReomote());
  locator.registerFactory<IUserOrdersDatasource>(() => UserOrderDatasourse());

  //repository

  locator.registerFactory<IAuthRepository>(() => AuthenticationRepository());

  locator.registerFactory<MYHomeRepository>(() => HomeRepository());

  locator.registerFactory<MyCharityRepository>(() => CharityRepository());

  locator.registerFactory<IpaymentRepository>(() => PaymentRepository());

  locator.registerFactory<IFactorsRepositorys>(() => FactorsRepositorys());

  locator.registerFactory<IDetailsOfSlidersRepositotys>(
      () => DetailsSlidersRepositorys());
  locator.registerFactory<IDamandRepository>(() => DamandRepository());

  locator.registerFactory<IprofileRepository>(() => ProfileRepository());

  locator.registerFactory<IAboutUsRepository>(() => AboutUsRepository());

  locator.registerFactory<IMarasematRepository>(() => MarasematRepository());
  locator.registerFactory<IWearthTypeRepository>(() => WearthTypeRepository());
  locator.registerFactory<IWearthTarhRepository>(() => WearthTarhRepository());
  locator
      .registerFactory<ICreatOrderRepositorey>(() => CreateOrderRepository());
  locator.registerFactory<IUserOrdersRepositorys>(() => UserOrderRepository());
}
