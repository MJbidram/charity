import 'package:charity/bloc/home_bloc/home_event.dart';
import 'package:equatable/equatable.dart';

abstract class CharityEvent extends Equatable {
  const CharityEvent();
}

class LoadFirstTypeEvent extends CharityEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoadSecandTypeEvent extends CharityEvent {
  final String firstType;
  const LoadSecandTypeEvent({required this.firstType});
  @override
  List<Object?> get props => [firstType];
}

class GetPaymentUrlEvent extends CharityEvent {
  final String idType;
  final String amount;
  final String token;
  const GetPaymentUrlEvent({
    required this.idType,
    required this.amount,
    required this.token,
  });
  @override
  List<Object?> get props => [idType, amount, token];
}

class OpenBrowserForPayEvent extends CharityEvent {
  final String url;
  const OpenBrowserForPayEvent({required this.url});
  @override
  List<Object?> get props => [url];
}

class CheckPaymentValidationEvent extends CharityEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ShortcutEvent extends CharityEvent {
  int id;
  String title;
  ShortcutEvent({required this.id, required this.title});
  @override
  // TODO: implement props
  List<Object?> get props => [id, title];
}
