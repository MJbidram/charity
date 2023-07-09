import 'package:charity/models/factors_model.dart';
import 'package:charity/models/user_orders_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserOrderState {}

class UserOrderInitState extends UserOrderState {}

class UserOrderLoadingState extends UserOrderState {}

class UserOrderLoadedState extends UserOrderState {
  Either<String, List<UserOrdersModel>> response;
  UserOrderLoadedState(this.response);
}
