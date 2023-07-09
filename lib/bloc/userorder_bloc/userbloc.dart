import 'package:charity/bloc/factors_bloc/factors_event.dart';
import 'package:charity/bloc/factors_bloc/factors_state.dart';
import 'package:charity/bloc/userorder_bloc/userblo_event.dart';
import 'package:charity/bloc/userorder_bloc/userbloc_state.dart';
import 'package:charity/data/repository/factors_repository.dart';
import 'package:charity/data/repository/user_orders_repository.dart';
import 'package:charity/di/di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserOrdersBloc extends Bloc<UserOrderEvent, UserOrderState> {
  final IUserOrdersRepositorys _repositorys = locator.get();
  UserOrdersBloc() : super(UserOrderInitState()) {
    on<UserOrderRequestListEvent>((event, emit) async {
      emit(UserOrderLoadingState());
      var response = await _repositorys.getUserOrders();
      emit(UserOrderLoadedState(response));
    });
  }
}
